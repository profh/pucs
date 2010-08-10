class PasswordTester
	 	def new_password
   		chars = ("a".."z").to_a + ("A".."Z").to_a + ("1".."9").to_a 
   		newpass = Array.new(10, '').collect{chars[rand(chars.size)]}.join
    	"#{newpass}"
	  end
end

r = PasswordTester.new
r.newpass




#require 'active_support/secure_random'

	#def random_password
	  	#@password =  /^\w{10}[a-z][A-Z]$/
	  	#require 'active_support/secure_random'
		#@password = SecureRandom.hex(5)
		
		#chars = ("a".."z").to_a + ("1".."9").to_a 
		#newpass = Array.new(8, '').collect{chars[rand(chars.size)]}.join
		
		#puts  "#{password}"
	
	# end
 



#=====================

#	r = RegexTester.new
#	r.pattern # => returns nil
#	r.pattern=/bb|[^b]{2}/

#	r = RegexTester.new(/cc|[^c]{2}/)
#	r.pattern # => returns pattern in parentheses above
#	r.pattern=/bb|[^b]{2}/

#======================

# Should match!
# regex = RegexTester.new
# regex.pattern =/^(http:\/\/)?www\.\w+\.(com|edu|org)$/
# puts regex.pattern
# regex.statements = "http://www.google.com"
# puts regex.statements
# regex.test

# ======================

# q = RegexTester.new(/^(http:\/\/)?www\.\w+\.(com|edu|org)$/)
# puts q.pattern
# q.statements = "apidock.com"
# q.test

#===============================================================

# a = RegexTester.new
# a.pattern = /^(http:\/\/)?www\.\w+\.(com|edu|org)$/
# a.statements = %w[http://www.google.com apidock.com www.microsoft.com http://www.heimann-family.org http://www.kli.org http://www.acac.net http://www.cmu.edu http://is.hss.cmu.edu www.amazon.co.uk]
# a.test_all

#=========================

#cc = RegexTester.new
#cc.statements = %w[1234567890123456 1234-5678-9012-3456 1234\ 5678\ 9012\ 3456 1234567890 #1234567890123456 1234|5678|9012|3456]
#cc.pattern = /^\d{16}$| ^(\d{4}-\d{4}-\d{4}-\d{4})$/
#OR
#cc.pattern = /^\d{16}$|^((\d{4}[ -]?){4})$/
#cc.test_all

#============================================================================

#cc = RegexTester.new
#cc.statements = %w[Santa#Fe Santa~Fe Santa/Fe Santa1Fe]
#cc.pattern = /^[a-z. -]+$/i
#cc.test_all










