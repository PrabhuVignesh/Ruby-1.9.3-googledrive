require "google/api_client"
require "google_drive"


# Authorizes with OAuth and gets an access token.
client = Google::APIClient.new
auth = client.authorization
auth.client_id = "Client ID"
auth.client_secret = "Client Secret"
auth.scope = [
  "https://www.googleapis.com/auth/drive",
  "https://spreadsheets.google.com/feeds/"
]
auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"

if !File.exist?('out.txt')
	print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
	print("2. Enter the authorization code shown in the page: ")
	auth.code = $stdin.gets.chomp
	auth.fetch_access_token!
	access_token = auth.access_token
	File.open("out.txt", 'w+') {|f| f.write(access_token) }


else
	access_token = File.open("out.txt")
	access_token = access_token.read
end

# Creates a session.
session = GoogleDrive.login_with_oauth(access_token)

# Gets list of remote files.
session.files.each do |file|
  #p file.title
end

session.upload_from_file("/home/vicky/Documents/ruby/prabhu.docx", "prabhu.docx", convert: false)
file = session.file_by_title("/home/vicky/Documents/ruby/prabhu.docx")
#file.download_to_file("hello.txt")
#file.update_from_file("/home/vicky/Documents/ruby/prabhu.docx")