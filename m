Content-Type: multipart/mixed; boundary="===============1435286789430657296=="
MIME-Version: 1.0
From: Fu, Elva <elva.fu@intel.com>
Subject: light test report for ofono v0.2
Date: Tue, 04 Aug 2009 17:27:38 +0800
Message-ID: <E2263E4A5B2284449EEBD0AAB751098402CE04E009@PDSMSX501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1435286789430657296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Test Environment
-------------------------------
general PC (pre-installed FC11)
	- ofono v0.2
	- phonesim package
mobile phone (use it as modem)
-------------------------------

Test Scope
-------------------------------
    - this round of testing is a light one. we mainly focus on checking bas=
ic functionality of ofono v0.2 (voice call, sms, phonebook etc.)
    - voice call, multiparty call, sms, phonebook and modem are tested in r=
eal network env. For others, we test them through simulator.
    - We also give a try on latest version to check whether the issues were=
 fixed in trunk.
-------------------------------

Test Summary
-------------------------------
the test result is positive. most functionalities work well. we could send/=
receive sms, accept/reject/hold a voice call etc. Thanks Denis and all deve=
lopers to make this happen!
Total 60 test cases were executed during this round of testing. Among them: =

Pass: 	56
Fail: 	4
-------------------------------

Issues
-------------------------------
most of them were fixed in trunk, thanks! :-)
1) can't read phonebook records.   (was fixed in trunk)
2) segment fault when sending sms to more than one recipients (was fixed in=
 trunk)
3) segment fault when sending multipage sms (was fixed in trunk)
4) timeout when reading records at the first time
-------------------------------

Details
-------------------------------
features		checkpoints			test results		comments	=

SMS             	Send/receive                        	pass
                 	Set service center address         pass
                 	More recipients                     	fail     			was fixe=
d in trunk                =

                 	More segment                     	fail       			was fixed=
 in trunk              =

Voice call      	Dial                                   	pass
                        Accept                        		pass
                        Reject                            	pass
                        Hold                                   	pass
                        Receive                           	pass
                        Release                           	pass
Multiparty call   	Create                            	pass
                        Hang up                           	pass
                        Private chat                         	pass
                        Hold                            		pass
Sim Phonebook	Read                                 	fail   			was fixed in =
trunk                    =

SS     		CF       				pass                            =

		CB    				pass                                         =

		CW    				pass                                        =

		CLIR/CLIP                                pass  =

Setting		AOC                     		pass  =

                  	CF/CB                                    	pass  =

GSM string                                                  	pass  =

Modem                          			pass
Networking                                    		pass
-------------------------------

Many thanks to Zhigang for his effort on execution!

Elva
--===============1435286789430657296==--

