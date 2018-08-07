# Copyright, 2018, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module Async
	module HTTP
		module Body
			module Reader
				# Read chunks from the body.
				def each(&block)
					self.body.each(&block)
				end
				
				# Reads the entire request/response body.
				def read
					if self.body
						self.body.join
					end
				end
				
				# Immediately stop reading the body. May close the underlying connection. Discards body.
				def stop(error = EOFError)
					if self.body
						self.body.stop(error)
						self.body = nil
					end
				end
				
				# Gracefully finish reading the body. This will buffer the remainder of the body.
				def finish
					if self.body
						self.body = self.body.close
					end
				end
				
				# Close the connection as quickly as possible. Discards body.
				def close
					self.stop
				end
				
				# Whether there is a body?
				def body?
					@body and !@body.empty?
				end
			end
		end
	end
end
