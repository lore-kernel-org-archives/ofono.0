Content-Type: multipart/mixed; boundary="===============7290579645847835441=="
MIME-Version: 1.0
From: Fu, Elva <elva.fu@intel.com>
Subject: light test report for oFono v0.7
Date: Fri, 16 Oct 2009 18:00:15 +0800
Message-ID: <E2263E4A5B2284449EEBD0AAB751098418E455B673@PDSMSX501.ccr.corp.intel.com>
In-Reply-To: <E2263E4A5B2284449EEBD0AAB7510984066EA87674@PDSMSX501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7290579645847835441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Test Environment
-------------------------------
general PC (pre-installed FC11)
	- oFono v0.7
	- phonesim package
mobile phone (use it as modem)
-------------------------------

Test Strategy&Approach
-------------------------------
1. Considering oFono release early release often, to make testing more effe=
ctive, we will run our test cases based on oFono release selected. New feat=
ure testing and bug verification may be involved too. we will not do testin=
g on every release. :-)
2. At early stage, we will focus on functional testing as some features are=
 not ready and APIs are not stable enough. We will do deep testing in futur=
e.
-------------------------------

Test Scope
-------------------------------
    - we mainly focus on checking basic functionalities implemented in oFon=
o v0.7 (voice call, sms, cell broadcast, phonebook, sim, supplementary serv=
ice, modem, pin code etc.)
    - voice call, multiparty call, phonebook, SIM and modem are tested in r=
eal network env. For others, we test them through simulator.  =

-------------------------------

Test Summary
-------------------------------
test result is good and only 4 bugs were submitted. :-)
Total 82 test cases were executed during this round of testing. =

Pass: 	78
Fail: 	4
-------------------------------

New Bugs
-------------------------------
6783 Can't receive a empty message  =

6680 can't see call history information with oFono v0.7 version  =

6682 Segment fault in novatel modem driver  =

5963 Supplementary Service interface will be locked after sending a USSD st=
ring  =


We will do more investigation whether it was oFono or phonesim issues later=
. :-)
-------------------------------

Details
-------------------------------
to make it readable, we summarized by feature list. :-)
Features        	checkpoints                 		test results     				comment=
s	=

---------------------------------------------------------------------------=
-------------------------------------------------
Call history 	Missed call                    	work well except for bug6680
                   	Outgoing call    			pass
                   	Incoming call             		work well except for bug6682
                   	Duration                 		pass
                   	Date                           		pass
SMS  		Send/receive          		work well except for bug6783
                   	Receive class0        		pass
                   	Set service center address     	pass
                   	More recipients                	pass
                   	More segments                  	pass
Cell Broadcast 	Receive a CB message           	pass
Voice call 	Dial                           		pass
                   	Accept                         		pass
                   	Reject                         		pass
                   	Hold                           		pass
                   	Receive                        		pass
                   	Release                        		pass
Multiparty call  	Create                          		pass
                   	Hang up                         	pass
                   	Private chat                    	pass
                   	Hold                            		pass
Voice mail 	Get number                      	pass
                   	Set number                      	pass
Sim Phonebook Read                            		pass
SS  		CF                              		pass
                   	CB                              		pass
                   	CW                              		pass
                   	CLIR/CLIP                       	pass
Setting  	AOC                             	pass
                   	CF/CB                           	pass
GSM String      	General String                  	pass
                   	USSD                            	fail due to bug5963
Modem     	Basic function                  	pass
Networking        Basic function                  	pass
SIM   	            Read IMSI                       	pass
                   	Read MSISDN                     	pass
                   	Read Emergency number          	pass
                   	Read SDN number                 	pass
                  	Enable pin code                 	pass
                   	Enter pin code                  	pass
                   	Change pin code                 	pass
                   	PUK code                        	pass
---------------------------------------------------------------------------=
-------------------------------------------------

Elva
--===============7290579645847835441==--

