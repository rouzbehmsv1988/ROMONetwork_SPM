
this is a network Swift package which has two access moethods to it. first is "requestPublisher" which gives back a combine anyPublisher object and you can sink the output by yourself and the second one "request" which also handles the cancellable data by itself. 

NOTE: do not forget to choose the developer branch when adding it to your xcode project.

USAGE: 

RoMoNetwork<YourDecodableResponse>.shared.request(ROMOEndpoint(baseURL: url, method: .get)) { data, error in
// use the response here
               }
               



