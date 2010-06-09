Content-Type: multipart/mixed; boundary="===============3460723329353970242=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: oFono v0.22 test report
Date: Wed, 09 Jun 2010 22:46:59 +0800
Message-ID: <B32E3D5F1713054290B4FF257B89C51A10A0098251@shsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3460723329353970242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Test Objective
--------------------------------------
This is QA regular release testing cycle for oFono released. Our testing fo=
cus would be new features exploration and regression testing, to ensure maj=
or issues for new features are exposed in timely fashion.

Test Environment
-------------------------------
General Features:
General PC (pre-installed FC12)
       - ofono v0.22
       - phonesim 1.2
HFP:
Netbook EeePC901
      - MeeGo20100424 image
      - Sony Ericsson C905, Nokia N95
      - ofono v0.22
      - Bluez v4.63 =

GPRS:
      - MBM modem
      - ofono v0.22
      - UNICOM 3G WCDMA network

Modem Emulator:
	 - test-server tool in ofono

-------------------------------
Test Scope
-------------------------------
The test will do full light functional validation, mainly focus on checking=
 implemented functionality of ofono v0.22 (voice call, message, cell broadc=
ast, phonebook, sim, supplementary service, modem management, voice mail, c=
all volume, call history, message history, GPRS, HFP, USSD) base on phonesi=
m simulator and some hardware devices.
As the dependence of modem, we will do PPP test with gsmdial later.

Test Summary
-------------------------------
During the v0.21 testing, we found the v0.22 release, so switch to v0.22 im=
mediately.
The test result is positive. Most functionalities work well and more stable,
we reported 1 major Bluetooth bug during HFP test, verified 4 bugs, so far,=
 no blocking, critical issues remain.

Executed total 276 test cases during this round of testing, and among them: =

Pass:     266
Fail:     10


New Bugs
-------------------------------
Bug 2782 Bluetooth lost connection after unload loopback module in PA.


Open bugs
-------------------------------
2515 nor S5 command not really work in modem emulator
2517 nor Non at command did not handle properly in modem emulator
2519 nor S3 command can not work normally without default value
8898 enh Spend long time on getting fail report of sms
10061 GSM Compliance issue in sim phonebook
9453 enh [Phonesim] To support UCS2 encode in Cell Broadcast Message
9371 nor Modem interface information didn't be updated after modem was remo=
ved
868 nor ussd notification display is incorrect with UCS2 character set
872 maj Can not deactivate all contexts


Fixed bugs
-------------------------------
8185 nor Segmentation fault in ste modem which may caused by call history

Verified Bugs
------------------------------
870 can't cancel/response ussd notification
434  Can't input pin code
435 Can't reset the pin code as the same old number
443 can't change the password by gsm string


Details
The every checkpoint would be one or more test case to cover and result is =
for functionality, besides you may find some functional limitation in comme=
nts

------------------------------
Features       checkpoints               test results       comments
Call history	Missed call				pass				=

			Outgoing call				pass				=

			Incoming call				pass				=

			Duration					pass				=

			Date						pass				=

SMS			Send/receive				pass               =

			Class0, 1					pass				=

			Set service center address	pass				=

			More segments				pass				=

			Different character set		pass				=


Voice call	Dial						pass				=

			Accept					pass				=

			Reject					pass				=

			Hold						pass				=

			Retrieve					pass				=

			Release					pass				=

			ECT						pass				=

Multiparty call	Create				pass				=

				Hang up				pass				=

				Private chat			pass				=

				Hold					pass				=

Sim Phonebook	Read						pass				=

			Different character set		pass				=

			Vcard3.0					pass				=

SS			CF						pass				=

			CB						pass 			=

			CW						pass				=

			CLIR/CLIP					pass				=

Setting		AOC						pass				=

			CF/CB					pass				=

GSM string	General strings			pass				=

			USSD						pass				=

USSD			Send						pass				=

			Cancel request			pass				=

			Respond					pass				=

			Different character set		fail				#868
Modem		Basic function			pass				=

			Two modems				pass				=

			Abnormal quit				fail				#9371
Voice mail	Get/Set number			pass				=

			Message Count				pass				=

			Notification				pass				=

			CPHS information			pass				=

Networking	Basic network information	pass				=

			Signal indicator			pass				=

			Scan						pass				=

			Register					pass				=

SIM file		Read IMSI					pass				=

			Read/set MSISDN			pass				=

			Read Emergency number		pass				=

			Read SDN number			pass				=

			PIN code					pass				=

			PUK						pass				=

Cell broadcast	Receive a CB message	pass				=

			Receive several CB messages	pass				=

			Receive more pages CB message pass          	=

			Different language 		pass				=

Call volume	Set/get volume			pass				=

			Mute/unmute				pass				=

Message history	Send history			pass				=

				Receive history		pass				=

				Date					pass				=

HFP			Voice call				pass				=

			Multiparty call			pass				=

			Networking				pass				=

			Call volume				pass				=

			Audio control				pass				=

GPRS			Active context			pass				=

			Edit profiles				pass				=

			Deactivate context			pass				=

			Deactivate all context		fail				#872
			Detach					pass				=

			Attach					pass				=

			Create context			pass				=

			Remove context			pass				=

Modem Emualtor	Basic AT command		pass				=

				Negative				fail			#2515,#2517,#2519

-------------------------------

Thanks
Zhigang


--===============3460723329353970242==--

