# places_api

This gem is a Ruby client for the Google Places API

## Installation

From the command line:

```shell
$ gem install places_api
```
From your application's Gemfile:

```shell
$ gem 'places_api'
```

## Usage

Currently, the gem supports the [Place Search](https://developers.google.com/places/documentation/search) and [Place Details](https://developers.google.com/places/documentation/details) endpoint, but support for the entire API is planned.

The arguments to each function in this gem are "simple" Ruby Objects (i.e. String, Fixnum), and the outputs are the raw JSON responses from the API, wrapped in a [`Hashie::Mash`](https://github.com/intridea/hashie#mash).
Result that return multiple objects are wrapped in an `Enumerator` to allow lazy request pagination.

This client will be used throughout the examples.
Replace $API_KEY with your Google Places API key.
Follow these [instructions](https://developers.google.com/places/documentation/index#Authentication) to get an API key.

```ruby
@client = PlacesAPI.new("$API_KEY")
```

The optional query parameters described in the API docs for [Search](https://developers.google.com/places/documentation/search) and [Details](https://developers.google.com/places/documentation/details) may be passed to each method as keyword arguments.

### Search

To perform a Nearby Search with, you must pass in the location and radius:

```ruby
@client.search.nearby('42.3581,-71.0636', radius: 1000).to_a
# =>
# [
#   {
#     "geometry" => {
#       "location" => {
#         "lat" => 42.3587999,
#         "lng" => -71.0707389
#       },
#       "viewport" => {
#         "northeast" => {
#           "lat" => 42.3611918,
#           "lng" => -71.0604501
#         },
#         "southwest" => {
#           "lat" => 42.3554044,
#           "lng" => -71.0730243
#         }
#       }
#     },
#     "icon" => "http =>//maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png",
#     "id" => "fac7126b486af397364666a201134b34436961e1",
#     "name" => "Beacon Hill",
#     "place_id" => "ChIJT84qgp5w44kR2MRBT4FBDq0",
#     "reference" => "CpQBiAAAABqnFqdr80Hf3vjd72o5dDlMyDnLx21Qy_VEFhRuqjc_OK3YeQ2jaRo6qQvVdQYzchgUwQB8nHbBkGB8kTHSXFMmasYcjxKnSIr3uuDZLyeiVm1EmWrTQMS-ugGa_G3IHlnIV3MN-NVnHDmprXRNBrL4jN-eTABQOzL_E9mTldWGw36VcEFmN4Z_hcFwqTPgYhIQ-WRFKpKwq0ZWaX1Yi6lGHhoUTyMkYbQH3CnThM3izAg5ZZAYqPU",
#     "scope" => "GOOGLE",
#     "types" => [
#       "neighborhood",
#       "political"
#     ],
#     "vicinity" => "Boston"
#   },
#   ...
# ]
```

Next, Text Search requests are as follows:

```ruby
@client.search.text('Bars near Boston, MA').to_a
# =>
# [
#   {
#     "formatted_address" => "69 Bromfield St, Boston, MA, United States",
#     "geometry" => {
#       "location" => {
#         "lat" => 42.357077,
#         "lng" => -71.060893
#       }
#     },
#     "icon" => "http =>//maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png",
#     "id" => "ee500cfbc42bc500febd167c0fb3e2a90f474a8a",
#     "name" => "Silvertone Bar & Grill",
#     "opening_hours" => {
#       "open_now" => true
#     },
#     "photos" => [
#       {
#         "height" => 512,
#         "html_attributions" => [],
#         "photo_reference" => "CnRnAAAAYlH24d_LIXTEdvI1_wkZObx4Js0j_QbRPJQtbjEnExaCagNF7ebT2CTVFzsKsh5zrVq5jrOz2Rh-rze9DzJP268H7zxLY1ay6IAifcJEe4VAjeZBj3UBAUZjwEAIaRUNWxZFskvvQ64m1tZOJj5tKRIQxK3SgP7jIqSoINuj9BAiqhoU-D2pBnUYvLV2gSGpMW6F4hmURxo",
#         "width" => 384
#       }
#     ],
#     "place_id" => "ChIJn13PWoNw44kRG5kzofMvl0c",
#     "price_level" => 2,
#     "rating" => 4.2,
#     "reference" => "CoQBeAAAAJaI9k4XfO3sZ0wfzDHv8_dGaiIWvZVgLiIGqbTMhTQPOXXU2a-_A03nNwKJIWNp5xRRGaiiGWu9eKlHfHX6haFuuWeQLnSjDAFdAf2QYzRjOZc-5bj6-NqJ3ns0kXow2nL3THcUI9yHlukYIeaKSdxCDrt-y7g5aZlqBCeg0viUEhBxSLypGI-mkWdihpjpjZeOGhQFfW3LLBOgoABS52nXBw571nKMNw",
#     "types" => [
#       "restaurant",
#       "food",
#       "establishment"
#     ]
#   },
#   ...
# ]
```

Finally Radar Search, which is like a Nearby Search but returns more results with less information, are as follows:

```ruby
@client.search.radar('42.3581,-71.0636', radius: 1000, types: 'bar').to_a
# =>
# [
#   {
#     "geometry" => {
#       "location" => {
#         "lat" => 42.360116,
#         "lng" => -71.055393
#       }
#     },
#     "id" => "e2698d7120ec37fda8e7dc707f2f00ce58c5ec11",
#     "place_id" => "ChIJb7nX2YVw44kRtgHbmPtsymA",
#     "reference" => "CnRoAAAA8ON-DCuGdr3X6Z8ZlzSiO2j8h4TS8_GqpKGFGzQzICKuajAQ4jXVbbOvXXdAJhZLA5VXfpU3tz2Ocn7AmCNAM6aTpsBfKiFM5wvurRYMhU6LW2iFSOBaCmnO0V1-zrxE59SQQUoU8aEKn2K_YMGdLRIQjsiNcOM5FclMF4PsltKeABoUQ5um3xATFMx7SK3_QNflaGBu_8w"
#   },
#   ...
# ]
```

### Details

The Place Details API endpoint returns extra information about a given place:

```ruby
@client.details(placeid: "ChIJT84qgp5w44kR2MRBT4FBDq0")
# =>
# {
#   "address_components" => [
#     {
#       "long_name" => "Beacon Hill",
#       "short_name" => "Beacon Hill",
#       "types" => [
#         "neighborhood",
#         "political"
#       ]
#     },
#     {
#       "long_name" => "Boston",
#       "short_name" => "Boston",
#       "types" => [
#         "locality",
#         "political"
#       ]
#     },
#     {
#       "long_name" => "Suffolk County",
#       "short_name" => "Suffolk County",
#       "types" => [
#         "administrative_area_level_2",
#         "political"
#       ]
#     },
#     {
#       "long_name" => "Massachusetts",
#       "short_name" => "MA",
#       "types" => [
#         "administrative_area_level_1",
#         "political"
#       ]
#     },
#     {
#       "long_name" => "United States",
#       "short_name" => "US",
#       "types" => [
#         "country",
#         "political"
#       ]
#     }
#   ],
#   "adr_address" => "Beacon Hill, <span class=\"locality\">Boston</span>, <span class=\"region\">MA</span>, <span class=\"country-name\">USA</span>",
#   "formatted_address" => "Beacon Hill, Boston, MA, USA",
#   "geometry" => {
#     "location" => {
#       "lat" => 42.3587999,
#       "lng" => -71.0707389
#     },
#     "viewport" => {
#       "northeast" => {
#         "lat" => 42.3611918,
#         "lng" => -71.0604501
#       },
#       "southwest" => {
#         "lat" => 42.3554044,
#         "lng" => -71.0730243
#       }
#     }
#   },
#   "icon" => "http =>//maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png",
#   "id" => "fac7126b486af397364666a201134b34436961e1",
#   "name" => "Beacon Hill",
#   "place_id" => "ChIJT84qgp5w44kR2MRBT4FBDq0",
#   "reference" => "CoQBfwAAANtqy-sdEAc-YRCWjnJ8frgyAPFz0QqltppKp18JJBckHiyQ-gaiD8gFfnDc3L8knkDo2nffG3MugeBBkWJdisuCToNkCm99IfhPAIt4waffT8SgVxgwgbYDMbQvw16oFUgBybTP0AFVTf7Y0RMMlDooTNUg-XTVD6Ptv1y4UIyEEhAHZM28ZpfMgYD4KXHFfaVLGhRjB-RnVfeUbI_LGyuwobtmIB_GPw",
#   "scope" => "GOOGLE",
#   "types" => [
#     "neighborhood",
#     "political"
#   ],
#   "url" => "https =>//maps.google.com/maps/place?q=Beacon+Hill,+Boston,+MA,+USA&ftid=0x89e3709e822ace4f =>0xad0e41814f41c4d8",
#   "vicinity" => "Boston"
# }
```

