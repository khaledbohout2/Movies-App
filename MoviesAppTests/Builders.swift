//
//  Builders.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 23/05/2025.
//

import Foundation
@testable import MoviesApp

struct MovieBuilder {
    private var id: Int = 1
    private var title: String = "Default Title"
    private var overview: String = "Default overview"
    private var posterPath: String? = nil
    private var tagline: String? = nil
    private var revenue: Int? = nil
    private var releaseDate: String? = nil
    private var status: String? = nil
    private var isWishlisted: Bool = false

    func withId(_ id: Int) -> MovieBuilder {
        var copy = self
        copy.id = id
        return copy
    }

    func withTitle(_ title: String) -> MovieBuilder {
        var copy = self
        copy.title = title
        return copy
    }

    func withIsWishlisted(_ isWishlisted: Bool) -> MovieBuilder {
        var copy = self
        copy.isWishlisted = isWishlisted
        return copy
    }

    func withOverview(_ overview: String) -> MovieBuilder {
        var copy = self
        copy.overview = overview
        return copy
    }
    
    func build() -> Movie {
        var movie = Movie(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            tagline: tagline,
            revenue: revenue,
            releaseDate: releaseDate,
            status: status
        )
        movie.isWishlisted = isWishlisted
        return movie
    }
}

struct MovieResponseBuilder {
    private var results: [Movie] = []
    private var page: Int = 1
    private var totalPages: Int = 1

    func withResults(_ results: [Movie]) -> MovieResponseBuilder {
        var copy = self
        copy.results = results
        return copy
    }

    func withPage(_ page: Int) -> MovieResponseBuilder {
        var copy = self
        copy.page = page
        return copy
    }

    func withTotalPages(_ totalPages: Int) -> MovieResponseBuilder {
        var copy = self
        copy.totalPages = totalPages
        return copy
    }

    func build() -> Movies {
        Movies(results: results, page: page, totalPages: totalPages)
    }
}

struct CastMemberBuilder {
    private var id: Int = 1
    private var name: String = "Default Actor"
    private var popularity: Double = 10
    private var knownForDepartment: KnownForDepartment? = .acting
    private var profilePath: String? = nil

    func withId(_ id: Int) -> CastMemberBuilder {
        var copy = self
        copy.id = id
        return copy
    }

    func withName(_ name: String) -> CastMemberBuilder {
        var copy = self
        copy.name = name
        return copy
    }

    func withPopularity(_ popularity: Double) -> CastMemberBuilder {
        var copy = self
        copy.popularity = popularity
        return copy
    }

    func withKnownForDepartment(_ department: KnownForDepartment?) -> CastMemberBuilder {
        var copy = self
        copy.knownForDepartment = department
        return copy
    }

    func build() -> CastMember {
        CastMember(id: id, name: name, popularity: popularity, knownForDepartment: knownForDepartment, profilePath: profilePath)
    }
}

struct CrewMemberBuilder {
    private var id: Int = 1
    private var name: String = "Default Crew"
    private var popularity: Double = 10
    private var knownForDepartment: KnownForDepartment = .directing
    private var job: String = "Director"
    private var profilePath: String? = nil

    func withId(_ id: Int) -> CrewMemberBuilder {
        var copy = self
        copy.id = id
        return copy
    }

    func withName(_ name: String) -> CrewMemberBuilder {
        var copy = self
        copy.name = name
        return copy
    }

    func withPopularity(_ popularity: Double) -> CrewMemberBuilder {
        var copy = self
        copy.popularity = popularity
        return copy
    }

    func withKnownForDepartment(_ department: KnownForDepartment) -> CrewMemberBuilder {
        var copy = self
        copy.knownForDepartment = department
        return copy
    }

    func withJob(_ job: String) -> CrewMemberBuilder {
        var copy = self
        copy.job = job
        return copy
    }

    func build() -> CrewMember {
        CrewMember(id: id, name: name, popularity: popularity, knownForDepartment: knownForDepartment, job: job, profilePath: profilePath)
    }
}

struct MovieCreditsBuilder {
    private var id: Int = 0
    private var cast: [CastMember] = []
    private var crew: [CrewMember] = []

    func withId(_ id: Int) -> MovieCreditsBuilder {
        var copy = self
        copy.id = id
        return copy
    }

    func withCast(_ cast: [CastMember]) -> MovieCreditsBuilder {
        var copy = self
        copy.cast = cast
        return copy
    }

    func withCrew(_ crew: [CrewMember]) -> MovieCreditsBuilder {
        var copy = self
        copy.crew = crew
        return copy
    }

    func build() -> MovieCredits {
        MovieCredits(id: id, cast: cast, crew: crew)
    }
}
