type Team <: GitHubType
    name::Nullable{GitHubString}
    description::Nullable{GitHubString}
    privacy::Nullable{GitHubString}
    permission::Nullable{GitHubString}
    slug::Nullable{GitHubString}
    id::Nullable{Int}
end

namefield(t::Team) = t.name

Team(data::Dict) = json2github(Team, data)

function members(team::Team; options...)
    results, page_data = gh_get_paged_json("/teams/$(get(team.id))/members"; options...)
    return map(Owner, results), page_data
end

