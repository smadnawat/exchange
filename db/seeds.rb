# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.create([{email: 'rahul@mobiloitte.com', password: 'password', password_confirmation: 'password', name: 'Rahul', is_admin: 'false'},
#            {email: 'admin@example.com', password: 'password', password_confirmation: 'password', name: 'Mark', is_admin: 'true'}
#           ])
 AdminUser.create(email: 'a@test.com', password: '11111111', password_confirmation: '11111111', username: 'username')
 AdminUser.create(email: 'ab@test.com', password: '11111111', password_confirmation: '11111111', username: 'usernamei')

 User.create(username: 'Testing name1', gender: 'Male', email: 'test1@gmail.com',password: '11111111', password_confirmation: '11111111',location: 'Okhla',date_signup: ' Wed, 10 Jun 2015 13:01:42 +0000',created_at:' Wed, 10 Jun 2015 13:01:42 +0000',updated_at: ' Wed, 10 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', provider: 'FB', u_id: 'sdsdsd',device_used: 'Samsung S4')
 User.create(username: 'Testing name2', gender: 'Male', email: 'test2@gmail.com',password: '22222222', password_confirmation: '22222222',location: 'Govindpuri',date_signup: ' Wed, 10 Jun 2015 13:01:42 +0000',created_at:' Wed, 10 Jun 2015 13:01:42 +0000',updated_at: ' Wed, 10 Jun 2015 13:01:42 +0000',latitude: '4.747',longitude: '35.77', provider: 'FB', u_id: 'sdsdeesd',device_used: 'Samsung S5')
 User.create(username: 'Testing name3', gender: 'Male', email: 'test3@gmail.com',password: '33333333', password_confirmation: '33333333',location: 'Mayur Vihar',date_signup: ' Wed, 10 Jun 2015 13:01:42 +0000',created_at:' Wed, 10 Jun 2015 13:01:42 +0000',updated_at: ' Wed, 10 Jun 2015 13:01:42 +0000',latitude: '4.737',longitude: '55.77', provider: 'FB', u_id: 'sdseedsd',device_used: 'Iphone 6 plus')

 # ReadingPreference.create(title: 'Testing title1', author: 'Testing author1', genre: 'Testing genre1',user_id: '1')
 # ReadingPreference.create(title: 'Testing title1', author: 'Testing author2', genre: 'Testing genre2',user_id: '1')
 # ReadingPreference.create(title: 'Testing title2', author: 'Testing author3', genre: 'Testing genre3',user_id: '2')
 # ReadingPreference.create(title: 'Testing title3', author: 'Testing author4', genre: 'Testing genre4',user_id: '1')
 # ReadingPreference.create(title: 'Testing title4', author: 'Testing author5', genre: 'Testing genre5',user_id: '2')
 # ReadingPreference.create(title: 'Testing title5', author: 'Testing author6', genre: 'Testing genre6',user_id: '1')
 # ReadingPreference.create(title: 'Testing title6', author: 'Testing author7', genre: 'Testing genre7',user_id: '2')
 Book.create(title: 'Testing bookA',author: 'AuthorA',genre: 'genreA',upload_date:  'Mon, 22 Jun 2015',upload_date_for_admin: 'Mon, 22 Jun 2015', upload_type: 'Manual', user_id: 1,created_at:' Mon, 22 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 22 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Delhi')
 Book.create(title: 'Testing bookB',author: 'AuthorB',genre: 'genreB',upload_date:  'Mon, 22 Jun 2015',upload_date_for_admin: 'Mon, 22 Jun 2015', upload_type: 'Manual', user_id: 1,created_at:' Mon, 22 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 22 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Delhi')
 Book.create(title: 'Testing bookC',author: 'AuthorC',genre: 'genreC',upload_date:  'Mon, 21 Jun 2015',upload_date_for_admin: 'Mon, 21 Jun 2015', upload_type: 'Manual', user_id: 2,created_at:' Mon, 21 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 21 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Ashok nagar')
 Book.create(title: 'Testing bookD',author: 'AuthorD',genre: 'genreD',upload_date:  'Mon, 21 Jun 2015',upload_date_for_admin: 'Mon, 21 Jun 2015', upload_type: 'Manual', user_id: 2,created_at:' Mon, 21 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 21 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Ashok nagar')
 Book.create(title: 'Testing bookE',author: 'AuthorE',genre: 'genreE',upload_date:  'Mon, 20 Jun 2015',upload_date_for_admin: 'Mon, 20 Jun 2015', upload_type: 'Manual', user_id: 3,created_at:' Mon, 20 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 20 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Okhla')
 Book.create(title: 'Testing bookF',author: 'AuthorF',genre: 'genreF',upload_date:  'Mon, 20 Jun 2015',upload_date_for_admin: 'Mon, 20 Jun 2015', upload_type: 'Manual', user_id: 3,created_at:' Mon, 20 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 20 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Okhla')
 

 TermsAndCondition.create(description: '<p>Welcome to Novelinked.com, operated by MakasharCreative (53294779K) a sole proprietorship duly registered in Singapore.  This agreement sets forth the legally binding Terms and Conditions for Your Use and Privacy Policy.</p>
							
							<p>
By accessing the Novelinked.com application or its website found at www.novelinked.com, whether through a mobile device, mobile application or computer (collectively, the “Service”) you agree to be bound by these Terms of Use and Privacy Policy (this “Agreement”), whether or not you created a Novelinked.com account.</p>
							
							<p>If you do not accept and agree to be bound by all of the terms of this Agreement, do not use the Service. If you have any questions, please contact us at talktome@makasharcreative.com.</p>
							
							<h2>Terms of Use</h2>
							<h2>1. Novelinked.com as a facilitator</h2>
							<p>Novelinked.com is a mobile only platform which uses book, author or genre preferences of its users together with location based services to provide: </p>
							
							<ul>
							<li>a. An opportunity to physical exchange used books among users</li>
							<li>b. A platform for social introductions which can be initiated through in-app messaging. 
	    Consequently, Novelinked.com is not an e-commerce application and thus does not seek to regulate or capture economic benefit 		            from the possible sale of second hand books.  </li>
							
							
							</ul>
							<h2>2. Eligibility</h2>
							<p>No part of Novelinked.com is directed to persons under the age of 18. You must be at least 18 years of age to access and use the Service. Any use of the Service is void where prohibited. By accessing and using the Service, you represent and warrant that you have the right, authority and capacity to enter into this Agreement and to abide by all of the terms and conditions of this Agreement. 
For individuals under the age of 18, they must at all times use Novelinked.com services only in conjunction with and under the supervision of a parent or legal guardian who is at least 18 years of age. This person is deemed to be responsible for any and all activities of this individual who is below the age of 18. </p>


							<h2>3. Password Security</h2>
							<p>Keep your password secure. You are fully responsible for all activity, liability and damage resulting from your failure to maintain password confidentiality. You agree to immediately notify Novelinked.com of any unauthorized use of your password or any breach of security. You also agree that Novelinked.com cannot and will not be liable for any loss or damage arising from your failure to keep your password secure. Further, you shall be liable for the losses of Novelinked.com or others due to such unauthorized use.</p>
							
							<h2>4. Fees and Service</h2>
							<p>Registration and using our services are free. However we reserve the right to start charging for existing or additional services at any time after serving a general press notice which is will be made available on our website www.novelinked.com<p>
							
							
							<h2>5. Use of Our Service</h2>
							<p>Subject to the terms and conditions of this agreement, Novelinked.com grants you permission to use the Service for your personal, non-commercial purposes only. You agree not to engage in any of the following prohibited activities: </p>
							
							<p>(i) copying, distributing, or disclosing any part of the Service in any medium, including without limitation by any automated or non-automated "scraping"; </p>
							
							<p>(ii) using any automated system, including without limitation "robots," "spiders," "offline readers," etc., to access the Service in a manner that sends more request messages to the Novelinked.com servers than a human can reasonably produce in the same period of time by using a conventional on-line web browser; </p>
							
							<p>(iii) attempting to interfere with, compromise the system integrity or security or decipher any transmissions to or from the servers running the Service; </p>
							
							<p>(iv) taking any action that imposes, or may impose at our sole discretion an unreasonable or disproportionately large load on our infrastructure;  </p>
							
							<p>(v) uploading invalid data, viruses, worms, or other software agents through the Service; </p>
							
							
							<p>(vi) collecting or harvesting any personally identifiable information, including account names and pictures from the Service;  </p>
							
							<p>(vii) using the Service for any commercial solicitation purposes; </p>
							
							<p>(viii) using any information obtained from the Service in order to harass, abuse, or harm another person, or in order to contact, advertise to, solicit, or sell to any Member without their prior explicit consent,  </p>
							
							<p>(ix) impersonating another person or otherwise misrepresenting your affiliation with a person or entity, conducting fraud, hiding or attempting to hide your identity;</p>
							
							<p>(x) interfering with the proper working of the Service; or, </p>
							
							<p>(xi) bypassing the measures we may use to prevent or restrict access to the Service. Novelinked.com may permanently or temporarily block, terminate, or otherwise refuse to permit you access to the Service without notice and liability for any reason, including if in Novelinked.com sole determination you violate any provision of this Agreement, or for no reason. Upon termination for any reason or no reason, you continue to be bound by this Agreement.
</p>
							<h2>6. Your interactions with Other Customers</p>
							<p>You are solely responsible for your interactions with other customers. You understand that Novelinked.com does not conduct background checks or screens users nor does it attempt to verify the statements of its customers. Novelinked.com is not responsible for the conduct of its customers which include but not limited to any discussions, deals or promises that transpire on the chat including the condition of the books, the price for exchange or location and timing of exchange. As noted in and without limiting section  12 and 13 below, in no event shall Novelinked, its sole proprietor or employees be liable (directly or indirectly) for any loss of damages whatsoever, whether direct indirect, general, special, compensatory, consequential, and/or incidental, arising out of or relating to the conduct of you or anyone else in connection with the use of the Service including, without limitation, death, bodily injury, emotional distress, and/or any other damages resulting from communications or meetings with other users or persons you meet through the Service. You agree to take all necessary precautions in all interactions with other users, particularly if you decide to communicate off the Service or meet in person, or if you decide to send money to another user. You should not provide any financial information (for example, your credit card details or bank account information), or wire or otherwise send money, to other users. If you do so, this is at your own risk and liability. </p>
							
							<h2>7. Cataloging books</h2>
							<p>By cataloging a book on Novelinked.com, you agree the book is in presentable conditions for other customers to read and is physically available with you. We are not responsible to either set of matched customers for the condition or availability of the matched books. </p>
							
							<h2>8. Our Service Levels</h2>
							<p>Our Service is subject to scheduled and unscheduled service interruptions. All aspects of the Service are subject to change or elimination, including the service itself at Novelinked.com’s sole discretion. Novelinked.com also reserves the right to interrupt the Service with or without prior notice for any reason or no reason.</p>
							
							<h2>9. Intellectual Property</h2>
							<p><b>a. Definition</b></p>
							<p>
For the purposes of this Agreement, "Intellectual Property Rights" means all patent rights, copyright rights, mask work rights, moral rights, rights of publicity, trademark, trade dress and service mark rights, goodwill, trade secret rights and other intellectual property rights as may now exist or hereafter come into existence, and all applications therefore and registrations, renewals and extensions thereof, under the laws of any state, country, territory or other jurisdiction.</p>
							
							<p><b>b. Content of the site</b></p>
							<p>
							You agree that the Site and Services, including but not limited to graphics, audio clips, and editorial content, contain proprietary information and material that is owned by Novelinked.com and/or its licensors, and is protected by applicable intellectual property and other laws, including but not limited to copyright, and that you will not use such proprietary information or materials in any way whatsoever except for use of the Site and Services in compliance with these Terms. No portion of the Site or Services may be reproduced in any form or by any means, unless previous written permission is obtained. You agree not to modify, rent, lease, loan, sell, distribute or create derivative works based on the Site or Services in any unauthorized way whatsoever. </p>

							<p><b>c. Copyrights of the book exchanged</b></p>
							<p>
							While you are well within your legal right (first sale doctrine) to resell or exchange the copy of the book which was obtained lawfully, you are not permitted to make additional copies and exchange them with other users. This would result in violation of applicable copyright law and may result in legal liabilities against yourself. We are in no way responsible or liable for this unauthorized copy of intellectual property and will report such infringement if noticed by us or brought to our notice.  </p>


							<h2>10. Customer Content</h2>
							<p><b>a. Sources</b></p>
							<p>
							Sources of user content include but not limited to content generated in the user profile, uploading book preferences, cataloging of books and information exchanged in the 
							In-App Chat Window with allow users to post comments, pictures, views on authors or books and other information ("User Content"). You are solely responsible for your User Content that you upload, publish, display, link to or otherwise make available (hereinafter, "post") on the Service, and you agree that we are only acting as a passive conduit for your distribution and publication of your User Content.</p>

							<p><b>b. User Behavior</b></p>
							<p><b>You agree not to post User Content that: </b></p>
							<p>(i) may create a risk of harm, loss, physical or mental injury, emotional distress, death, disability, disfigurement, or physical or mental illness to you, to any other person, or to any animal; </p>

							<p>(ii) may create a risk of any other loss or damage to any person or property;  </p>

							<p>(iii) seeks to harm or exploit children by exposing them to inappropriate content, asking for personally identifiable details or otherwise; 
							 </p>

							<p>(iv) may constitute or contribute to a crime or tort;  </p>

							<p>(v) contains any information or content that we deem to be unlawful, harmful, abusive, racially or ethnically offensive, defamatory, infringing, invasive of personal privacy or publicity rights, harassing, humiliating to other people (publicly or otherwise), libelous, threatening, profane, or otherwise objectionable; </p>

							<p>(vi) contains any information or content that is illegal (including, without limitation, the disclosure of insider information under securities law or of another party’s trade secrets); or </p>

							<p>((vii) contains any information or content that you do not have a right to make available under any law or under contractual or fiduciary relationships; or  </p>

							<p>(viii) contains any information or content that you know is not correct and current. You agree that any User Content that you post does not and will not violate third-party rights of any kind, including without limitation any Intellectual Property Rights (as defined below), rights of publicity and privacy. Novelinked.com reserves the right, but is not obligated, to reject and/or remove any User Content that Novelinked.com believes, in its sole discretion, violates these provisions.  </p>

							
							<p><b>c. Data Management</b></p>
							<p>
							We reserve the right to purge data stored from the chat room, cataloged books as well as preferences which has not been used for more than 90 days without giving prior notice.  </p>

							
							<h2>11. No Warranty</h2>
							<p>This service is provided on an “As Is” and “As Available” basis. Use of the service is at your own risk. The service is provided without warranties of any kind, whether express or implied, including, but not limited to, implied warranties of merchantability, fitness for a particular purpose or non-infringement. Without limiting the foregoing, Novelinked.com, it subsidiaries and its licensors if any do not warrant that the content is accurate, reliable or correct, that the service will meet your requirements, that the service will be available at any particular time or location, uninterrupted or secure, that any defects or errors will be corrected, or that the service is free of viruses or other harmful components. Any content downloaded or otherwise obtained through the use of the service is downloaded at your own risk and you will be solely responsible for any damage to your mobile phone, tablet or computer or loss of data that results from such download. 
</p>
							
							<p>Novelinked.com does not warrant, endorse, guarantee or assume responsibility for any product or service advertised or offered by a third party through the service or any hyperlinked website or service, or featured in any banner or other advertising, nor will Novelinked.com be a party to or in any way monitor any transaction between you and third-party providers of products of services. </p>
							
							<h2>12.  Limitation of Liability</h2>
							<p>
								In no event shall Novelinked.com and (as applicable) its sole proprietor, employees or its suppliers be liable for any damages whatsoever, whether direct, indirect, general, special, compensatory, consequential, and/or incidental, arising out of or relating to the conduct of you or anyone else in connection with the use of the site, Novelinked.com’s services, or this agreement, including without limitation, lost profit, bodily injury, emotional distress, or any special, incidental or consequential damages. Novelinked.com’s liability and (as applicable) the liability of its sole proprietor, employees and suppliers, to you or to any third parties in any circumstances is limited to SGD 1. Some states do not allow the exclusion of limitation or incidental or consequential damages, so the above limitation or exclusion may not apply to you. </p>
							
							<h2>113. Indemnity</h2>
							<p>
								You agree to indemnify and hold Novelinked.com and (as applicable) Novelinked.com’s sole proprietor, employees and agents harmless from any claim or demand, including reasonable attorney’s fees made by any third party due to or arising out of your breach of this agreement or the documents it incorporates by reference, or your violation of any law or the rights of a third party.  </p>
							
							
							
							<p> 
Effective date: June 22, 2015. MakasharCreative reserves the right to alter these policies at any time. 
							</p>')








