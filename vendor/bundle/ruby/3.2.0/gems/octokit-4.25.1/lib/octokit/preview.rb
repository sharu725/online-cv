# frozen_string_literal: true

module Octokit
  # Default setup options for preview features
  module Preview
    PREVIEW_TYPES = {
      applications_api: 'application/vnd.github.doctor-strange-preview+json',
      branch_protection: 'application/vnd.github.luke-cage-preview+json',
      commit_search: 'application/vnd.github.cloak-preview+json',
      commit_pulls: 'application/vnd.github.groot-preview+json',
      commit_branches: 'application/vnd.github.groot-preview+json',
      migrations: 'application/vnd.github.wyandotte-preview+json',
      licenses: 'application/vnd.github.drax-preview+json',
      source_imports: 'application/vnd.github.barred-rock-preview',
      reactions: 'application/vnd.github.squirrel-girl-preview',
      transfer_repository: 'application/vnd.github.nightshade-preview+json',
      issue_timelines: 'application/vnd.github.mockingbird-preview+json',
      nested_teams: 'application/vnd.github.hellcat-preview+json',
      pages: 'application/vnd.github.mister-fantastic-preview+json',
      projects: 'application/vnd.github.inertia-preview+json',
      traffic: 'application/vnd.github.spiderman-preview',
      topics: 'application/vnd.github.mercy-preview+json',
      community_profile: 'application/vnd.github.black-panther-preview+json',
      strict_validation: 'application/vnd.github.speedy-preview+json',
      template_repositories: 'application/vnd.github.baptiste-preview+json',
      project_card_events: 'application/vnd.github.starfox-preview+json',
      vulnerability_alerts: 'application/vnd.github.dorian-preview+json'
    }.freeze

    def ensure_api_media_type(type, options)
      if options[:accept].nil?
        options[:accept] = PREVIEW_TYPES[type]
        warn_preview(type)
      end
      options
    end

    def warn_preview(type)
      octokit_warn <<~EOS
        WARNING: The preview version of the #{type.to_s.capitalize} API is not yet suitable for production use.
        You can avoid this message by supplying an appropriate media type in the 'Accept' request
        header.
      EOS
    end
  end
end
