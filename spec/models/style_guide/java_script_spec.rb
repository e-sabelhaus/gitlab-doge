require "fast_spec_helper"
require "jshintrb"
require "app/models/default_config_file"
require "app/models/violation"
require "app/models/style_guide/base"
require "app/models/style_guide/java_script"

describe StyleGuide::JavaScript do
  include ConfigurationHelper

  describe "#violations_in_file" do
    context "with default config" do
      context "when semicolon is missing" do
        it "returns violation" do
          repo_config = double("RepoConfig", for: {})
          file = double(:file, content: "var blahh = 'blahh'").as_null_object

          violations = violations_in(file, repo_config)

          expect(violations.first.messages).to include "Missing semicolon."
        end
      end
    end

    context "when semicolon check is disabled in config" do
      context "when semicolon is missing" do
        it "returns no violation" do
          repo_config = double("RepoConfig", for: { "asi" => true })
          file = double(:file, content: "parseFloat('1')").as_null_object

          violations = violations_in(file, repo_config)

          expect(violations).to be_empty
        end
      end
    end

    context "when jshintrb returns nil violation" do
      it "returns no violations" do
        repo_config = double("RepoConfig", for: {})
        file = double(:file).as_null_object
        allow(Jshintrb).to receive_messages(lint: [nil])

        violations = violations_in(file, repo_config)

        expect(violations).to be_empty
      end
    end

    context "when a global variable is ignored" do
      it "returns no violations" do
        repo_config = double("RepoConfig", for: { "predef" => ["myGlobal"] })
        file = double(:file, content: "$(myGlobal).hide();").as_null_object

        violations = violations_in(file, repo_config)

        expect(violations).to be_empty
      end
    end

    context "non-thoughtbot pull request" do
      it "uses the default hound configuration" do
        spy_on_file_read
        spy_on_jshintrb
        configuration_file_path = default_configuration_file(
          StyleGuide::JavaScript
        )
        file = double(:file, content: "$(myGlobal).hide();").as_null_object
        repo_config = double("RepoConfig", for: {})

        violations_in(file, repo_config)

        expect(File).to have_received(:read).with(configuration_file_path)
        expect(Jshintrb).to have_received(:lint).
          with(anything, default_configuration)
      end
    end

    context "thoughtbot pull request" do
      it "uses the thoughtbot hound configuration" do
        spy_on_file_read
        spy_on_jshintrb
        file = double(:file, content: "$(myGlobal).hide();").as_null_object
        configuration_file_path = thoughtbot_configuration_file(
          StyleGuide::JavaScript
        )
        repo_config = double("RepoConfig", for: {})

        violations_in(file, repo_config)

        expect(File).to have_received(:read).with(configuration_file_path)
        expect(Jshintrb).to have_received(:lint).
          with(anything, thoughtbot_configuration)
      end
    end
  end

  describe "#file_included?" do
    context "file is in excluded file list" do
      it "returns false" do
        repo_config = double("RepoConfig", ignored_javascript_files: ["foo.js"])
        style_guide = StyleGuide::JavaScript.new(repo_config)
        file = double(:file, filename: "foo.js")

        included = style_guide.file_included?(file)

        expect(included).to be false
      end
    end

    context "file is not excluded" do
      it "returns true" do
        repo_config = double("RepoConfig", ignored_javascript_files: ["foo.js"])
        style_guide = StyleGuide::JavaScript.new(repo_config)
        file = double(:file, filename: "bar.js")

        included = style_guide.file_included?(file)

        expect(included).to be true
      end
    end

    it "matches a glob pattern" do
      repo_config = double(
        "RepoConfig",
        ignored_javascript_files: ["app/assets/javascripts/*.js"]
      )

      style_guide = StyleGuide::JavaScript.new(repo_config)
      file = double(:file, filename: "app/assets/javascripts/bar.js")

      included = style_guide.file_included?(file)

      expect(included).to be false
    end
  end

  def violations_in(file, repo_config)
    style_guide = StyleGuide::JavaScript.new(repo_config)
    style_guide.violations_in_file(file)
  end

  def default_configuration
    config_file_path = default_configuration_file(StyleGuide::JavaScript)
    config_file = File.read(config_file_path)
    JSON.parse(config_file)
  end

  def thoughtbot_configuration
    config_file_path = thoughtbot_configuration_file(StyleGuide::JavaScript)
    config_file = File.read(config_file_path)
    JSON.parse(config_file)
  end

  def spy_on_jshintrb
    allow(Jshintrb).to receive(:lint).and_return([])
  end
end
