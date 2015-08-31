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

 # User.create(username: 'Testing name1', gender: 'Male', email: 'test1@gmail.com',password: '11111111', password_confirmation: '11111111',location: 'Okhla',date_signup: ' Wed, 10 Jun 2015 13:01:42 +0000',created_at:' Wed, 10 Jun 2015 13:01:42 +0000',updated_at: ' Wed, 10 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', provider: 'FB', u_id: 'sdsdsd',device_used: 'Samsung S4')
 # User.create(username: 'Testing name2', gender: 'Male', email: 'test2@gmail.com',password: '22222222', password_confirmation: '22222222',location: 'Govindpuri',date_signup: ' Wed, 10 Jun 2015 13:01:42 +0000',created_at:' Wed, 10 Jun 2015 13:01:42 +0000',updated_at: ' Wed, 10 Jun 2015 13:01:42 +0000',latitude: '4.747',longitude: '35.77', provider: 'FB', u_id: 'sdsdeesd',device_used: 'Samsung S5')
 # User.create(username: 'Testing name3', gender: 'Male', email: 'test3@gmail.com',password: '33333333', password_confirmation: '33333333',location: 'Mayur Vihar',date_signup: ' Wed, 10 Jun 2015 13:01:42 +0000',created_at:' Wed, 10 Jun 2015 13:01:42 +0000',updated_at: ' Wed, 10 Jun 2015 13:01:42 +0000',latitude: '4.737',longitude: '55.77', provider: 'FB', u_id: 'sdseedsd',device_used: 'Iphone 6 plus')

 # # ReadingPreference.create(title: 'Testing title1', author: 'Testing author1', genre: 'Testing genre1',user_id: '1')
 # # ReadingPreference.create(title: 'Testing title1', author: 'Testing author2', genre: 'Testing genre2',user_id: '1')
 # # ReadingPreference.create(title: 'Testing title2', author: 'Testing author3', genre: 'Testing genre3',user_id: '2')
 # # ReadingPreference.create(title: 'Testing title3', author: 'Testing author4', genre: 'Testing genre4',user_id: '1')
 # # ReadingPreference.create(title: 'Testing title4', author: 'Testing author5', genre: 'Testing genre5',user_id: '2')
 # # ReadingPreference.create(title: 'Testing title5', author: 'Testing author6', genre: 'Testing genre6',user_id: '1')
 # # ReadingPreference.create(title: 'Testing title6', author: 'Testing author7', genre: 'Testing genre7',user_id: '2')
 # Book.create(title: 'Testing bookA',author: 'AuthorA',genre: 'genreA',upload_date:  'Mon, 22 Jun 2015',upload_date_for_admin: 'Mon, 22 Jun 2015', upload_type: 'Manual', user_id: 1,created_at:' Mon, 22 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 22 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Delhi')
 # Book.create(title: 'Testing bookB',author: 'AuthorB',genre: 'genreB',upload_date:  'Mon, 22 Jun 2015',upload_date_for_admin: 'Mon, 22 Jun 2015', upload_type: 'Manual', user_id: 1,created_at:' Mon, 22 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 22 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Delhi')
 # Book.create(title: 'Testing bookC',author: 'AuthorC',genre: 'genreC',upload_date:  'Mon, 21 Jun 2015',upload_date_for_admin: 'Mon, 21 Jun 2015', upload_type: 'Manual', user_id: 2,created_at:' Mon, 21 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 21 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Ashok nagar')
 # Book.create(title: 'Testing bookD',author: 'AuthorD',genre: 'genreD',upload_date:  'Mon, 21 Jun 2015',upload_date_for_admin: 'Mon, 21 Jun 2015', upload_type: 'Manual', user_id: 2,created_at:' Mon, 21 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 21 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Ashok nagar')
 # Book.create(title: 'Testing bookE',author: 'AuthorE',genre: 'genreE',upload_date:  'Mon, 20 Jun 2015',upload_date_for_admin: 'Mon, 20 Jun 2015', upload_type: 'Manual', user_id: 3,created_at:' Mon, 20 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 20 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Okhla')
 # Book.create(title: 'Testing bookF',author: 'AuthorF',genre: 'genreF',upload_date:  'Mon, 20 Jun 2015',upload_date_for_admin: 'Mon, 20 Jun 2015', upload_type: 'Manual', user_id: 3,created_at:' Mon, 20 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 20 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Okhla')
 

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
							<h2>6. Your interactions with Other Customers</h2>
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
							
							<h2>13. Indemnity</h2>
							<p>
								You agree to indemnify and hold Novelinked.com and (as applicable) Novelinked.com’s sole proprietor, employees and agents harmless from any claim or demand, including reasonable attorney’s fees made by any third party due to or arising out of your breach of this agreement or the documents it incorporates by reference, or your violation of any law or the rights of a third party.  </p>
							
							
							
							<p> 
Effective date: June 22, 2015. MakasharCreative reserves the right to alter these policies at any time. 
							</p>')



PrivacyPolicy.create(description: '<h2>1. Information we collect about you</h2>
							<p>We collect information that can identify you such as your email address and gender ("personal information") and other information that does not identify you (author and genre preferences, catalogued books, reading preferences and about me). We may collect this information through our website or mobile application.</br> 
By using the Service, you are authorizing us to gather, retain data and analyze this data.Information you provide. In order to register as a user with Novelinked, you will be asked to register using Novelinked login screen or Facebook or Google + credentials.  For login via Facebook and Google +, you authorize us to access public profile information of these social media sites. We only obtain information from your Facebook / Google + accounts that you specifically authorize and grant us permission to obtain. 
In addition, we may collect and store any personal information you provide while using our Service or in some other manner. You may also provide us a profile picture, a personal description about you and information about your reading preferences. If you chat with other Novelinked users, you provide us access to the content of your chats, and if you contact us with a customer service or other inquiry, you provide us with the content of that communication.</br>
Use of technologies to collect information. We use various technologies to help us better understand how people use our service. 
Information collected automatically. We automatically collect information from your browser or device when you visit our Site / Service. This information could include your IP address, device ID and type, your browser type and language, the operating system used by your device, access times, your mobile device’s geographic location while our application is actively running, and the referring website address.</br>
Cookies and Use of Cookie Data.  We use “cookies” to keep track of some types of information while you are visiting Novelinked.com or using our services. “Cookies” are very small files placed on your computer, and they allow us to count the number of visitors to our Website and distinguish repeat visitors from new visitors. They also allow us to save user preferences and track user trends. We rely on cookies for the proper operation of Novelinked.com; therefore if your browser is set to reject all cookies, Novelinked.com may not function properly. Users who refuse cookies assume all responsibility for any resulting loss of functionality with respect to Novelinked.com</br>
Information collected by third-parties for advertising purposes. We allow ad networks and Real Time Buying (RTB’s) Exchanges to display advertisements on our Service. These companies may use tracking technologies, such as cookies or web beacons, to collect information about users who view or interact with their advertisements. We do not provide any personal information to third parties. </p>
							<h2>2. How we use the information we collect</h2>
							<p>General. We may use information that we collect about you to:</p>
							<ul>
							<li>Deliver accurate location based book matches;</li>
							<li>Manage your account and provide you with customer support;</li>
							<li>Perform research and analysis about your use of, or interest in our or others’ products, services, or content;</li>
							<li>Communicate with you by email about products or services that may be of interest to you either from us or other third parties;
	</li>
							<li>Develop, display, and track content and advertising tailored to your interests on our Service and other sites, including providing our advertisements to you when you visit other sites;
</li>
							<li>Website or mobile application analytics;</li>
							<li>Enforce or exercise any rights in our Terms of Use; and</li>
							<li>Perform functions or services as otherwise described to you at the time of collection.</li>
							
							</ul>
							<p>In all circumstances, we may perform these functions directly or use a third party vendor to perform these functions on our behalf who will be obligated to use your personal information only to perform services for us. Also, if you access our Service from a third party social platform, such as Facebook or Google +, we may share non-personal information with that platform to the extent permitted by your agreement with it and its privacy settings.
</p>
							<h2>3. With whom we share your information</h2>
							<p>Information Shared with Other Users. When you register as a user of Novelinked (either within the Application or using Social Media), your Novelinked profile will be viewable by other users of the Service as it relates to the following information only (i) User Name (ii) Profile Picture (iii) Gender (iv) Reading Preferences (v) Catalogued Books (vi) About me (vii) And my Ratings given by other users (users details of the reviewer are not disclosed). We also request for using location services at the time of barcode scanning to improve the relevance of the match. We only disclose the approximate km’s away from one matched customer to the other and seek your permission before we use location services.</p>
							<p><b>Personal information.</b>We do not share your personal information with others except as indicated in this Privacy Policy or when we inform you and give you an opportunity to opt out of having your personal information shared. 
We may share personal information with:</p>
							<ul>
							<li><b>Service providers:</b>t We may share personal information with third parties that perform certain services on our behalf. These services may include ad tracking and analytics, in house surveys (solely for the purposes of knowing customers’ needs better). These service providers may have access to personal information needed to perform their functions but are not permitted to share or use such information for any other purposes.</li>
							<li><b>Other Situations</b>We may disclose your information, including personal information:</li>
							
								<ul>
								<li>In response to a subpoena or similar investigative demand, a court order, or a request for cooperation from a law enforcement or other government agency; to establish or exercise our legal rights; to defend against legal claims; or as otherwise required by law. In such cases, we may raise or waive any legal objection or right available to us.</li>
								<li>When we believe disclosure is appropriate in connection with efforts to investigate, prevent, or take other action regarding illegal activity, suspected fraud or other wrongdoing; to protect and defend the rights, property or safety of the sole proprietorship, our users, our employees, or others; to comply with applicable law or cooperate with law enforcement; or to enforce our Terms of Use or other agreements or policies.
</li>
								<li>In connection with a substantial corporate transaction, such as the sale of our business, a divestiture, merger, consolidation, or asset sale, or in the unlikely event of bankruptcy.</li>
								
								</ul>
							
							
							</ul>
							<p><b>Aggregated and/or non-personal information.</b> We may use and share non-personal information we collect under any of the above circumstances. We may also share it with third parties to develop and deliver targeted advertising or products on our Service and on websites or applications of third parties, and to analyze and report on advertising you see. </p>


							<h2>4. How you can access your information</h2>
							<p>If you have a Novelinked account, you have the ability to review and update your personal information within the Service by opening your account and going to settings. You also may close your account at any time by uninstalling the application.  If you close your account, we will retain certain information associated with your account for analytical purposes and recordkeeping integrity, as well as to prevent fraud, enforce our Terms of Use, take actions we deem necessary to protect the integrity of our Service or our users, or take other actions otherwise permitted by law. In addition, if certain information has already been provided to third parties as described in this Privacy Policy, retention of that information will be subject to those third parties policies.</p>
							
							<h2>5. Your choices about collection and use of your information</h2>
							<ul>
								<li>You can choose not to provide us with certain information like location, access to location based services, your book preferences or catalogued books, but that will result in you being unable to use certain features of our Service because such information may be required to find a suitable book match. </li>	
								
								<li>Our Service may also deliver notifications to your phone or mobile device. You can disable these notifications by opting out of it, the button of which is located at the bottom of the My Profile Screen. </li>
								
								<li>You can also control information collected by cookies. You can delete or decline cookies by changing your browser settings. Click “help” in the toolbar of most browsers for instructions.</li>
							</ul>
							
							<h2>6. How we protect your personal information</h2>
							<p>We take security measures to help safeguard your personal information from unauthorized access and disclosure. However, no system can be completely secure. Therefore, although we take steps to secure your information, we do not promise, and you should not expect, that your personal information, chats, or other communications will always remain secure. Users should also take care with how they handle and disclose their personal information and should avoid sending personal information through insecure email. </p>
							<h2>Information you provide about yourself while using our Service</h2>
							<p>We provide areas on our Service where you can show information about yourself and communicate with others. Such postings are governed by our Terms of Use. Also, whenever you voluntarily disclose personal information on publicly-viewable pages, that information will be publicly available and can be collected and used by others. For example, if you post your email address, you may receive unsolicited messages. We cannot control who reads your posting or what other users may do with the information you voluntarily post, so we encourage you to exercise discretion and caution with respect to your personal information.</p>
							
							<h2>7. Children privacy</h2>
							<p>We restrict the use of our service to individuals age 18 and above. We do not knowingly collect, maintain, or use personal information from persons under the age of 18.</p>
							
							<h2>8. Visiting our Service from outside the United States</h2>
							<p>If you are visiting our Service from outside the United States, please be aware that your information may be transferred to, stored, and processed in the United States and globally where our servers are located and our central database is operated. By using our services, you understand and agree that your information may be transferred to our facilities and those third parties with whom we share it as described in this privacy policy.</p>
							
							<h2>9. No Rights of Third Parties</h2>
							<p>
This Privacy Policy does not create rights enforceable by third parties or require disclosure of any personal information relating to users of the website.
</p>
							
							<h2>10. Changes to this Privacy Policy</h2>
							<p>
We will occasionally update this Privacy Policy. When we post changes to this Privacy Policy, we will revise the "last updated" date at the top of this Privacy Policy. We recommend that you check our Service from time to time to inform yourself of any changes in this Privacy Policy or any of our other policies.</p>
							
							<h2>11. How to contact us</h2>
							<p>If you have any questions about this Privacy Policy, please contact us by email at talktome@makasharcreative.com</p>
							
							
							<p> 
Effective date: June 22, 2015. MakasharCreative reserves the right to alter these policies at any time.
							</p>')




