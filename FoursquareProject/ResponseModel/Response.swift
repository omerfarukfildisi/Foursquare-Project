
import Foundation

struct FoursquareResponseModel: Decodable {
    var response: VenuesResponseModel?
}

struct VenuesResponseModel: Decodable {
	let venues : [VenueResponseModel]?
}
