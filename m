Content-Type: multipart/mixed; boundary="===============2363383658481675514=="
MIME-Version: 1.0
From: Nagarajan, Guru <guru.nagarajan@intel.com>
Subject: RE: light test report for ofono v0.3
Date: Mon, 24 Aug 2009 21:31:27 -0700
Message-ID: <BC67582D4FC8ED45BAABE48343BF5711036B14BAF4@azsmsx501.amr.corp.intel.com>
In-Reply-To: <E2263E4A5B2284449EEBD0AAB7510984066EA87674@PDSMSX501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2363383658481675514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks Elva. =


-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Fu, Elva
Sent: Monday, August 24, 2009 8:46 PM
To: ofono(a)ofono.org
Subject: light test report for ofono v0.3

Test Environment
-------------------------------
general PC (pre-installed FC11)
	- ofono v0.3
	- phonesim package
mobile phone (use it as modem)
-------------------------------

Test Scope
-------------------------------
    - we mainly focus on checking basic functionality of ofono v0.3 (voice =
call, sms, phonebook etc.)
    - voice call, multiparty call, phonebook, SIM and modem are tested in r=
eal network env. For others, we test them through simulator.
    - bug verification: verify issues we found in v0.2
-------------------------------

Test Summary
-------------------------------
there are small changes between ofono v0.2 and v0.3.  so good test result i=
s expected. :-)
Total 63 test cases were executed during this round of testing. =

Pass: 	63
Fail: 	0
issues we found in v0.2 were fixed already, many thanks!
-------------------------------

Details
-------------------------------
to make it readable, we summarized by feature list. :-)

features		checkpoints			test results		comments	=

SMS             	Send/receive                        	pass
                 	Set service center address         pass
                 	More recipients                     	pass			             =
   =

                 	More segment                     	pass			              =

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
Sim Phonebook	Read                                 	pass			                =
    =

SS     		CF       				pass                            =

		CB    				pass                                         =

		CW    				pass                                        =

		CLIR/CLIP                                pass  =

Setting		AOC                     		pass  =

                  	CF/CB                                    	pass  =

GSM string                                                  	pass  =

Modem                          			pass
Networking                                    		pass
Sim		Read IMSI			pass
		Read MSISDN			pass
-------------------------------

Elva
_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono

--===============2363383658481675514==--

