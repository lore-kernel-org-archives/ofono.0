Content-Type: multipart/mixed; boundary="===============8794060853832940299=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: oFonov0.17 light test report
Date: Wed, 10 Feb 2010 17:20:01 +0800
Message-ID: <AE1A29481078F64FB2A6D4BA2B68C2FEA9DEBD00@shzsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8794060853832940299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Test Environment
-------------------------------
General PC (pre-installed FC12)
- ofono v0.17
- phonesim package
- (HFP) Latest BlueZ git tree + Sony Ericsson C905
- (GPRS) Moblin 2.2 + Unicom WCDMA network + MBM modem
-------------------------------
Test Scope
-------------------------------
    - All implemented features in oFonov0.17 are covered, We did light func=
tional validation in this round testing on these features (voice call, mess=
age, cell broadcast, phonebook, sim, supplementary service, modem, voice ma=
il, call volume, call history, message history.) with phonesim simulator as=
 the target STE modem is not ready and basic functional validation on HFP, =
GPRS with real hardware environment. We will do full test for HFP, GPRS lat=
er.
-------------------------------

Test Summary
-------------------------------
The test result is positive. Most functionalities work well and more stable,
we reported 4 new bugs, updated 2 old bugs, verified 1 bugs, and one major =
bug was quickly fixed by developer, thanks. So far, no blocking, major issu=
es remain.
Executed total 202 test cases during this round of testing, and among them: =

Pass:     196
Fail:       6
-------------------------------

New Bugs
-------------------------------
9370 nor No phonesim application when enable real modem and phonesim togeth=
er  =

9371 nor Modem interface information didn't be updated after modem was remo=
ved  =

9453 enh [Phonesim] To support UCS2 encode in Cell Broadcast Message  =

9374 maj Segment fault with more char CBS [fixed by developer already]

Remaining Old Open bugs
-------------------------------
8185 nor Segmentation fault in ste modem which may caused by call history
8898 enh Spend long time on getting fail report of sms

Verified Bugs
-------------------------------
9089 maj Phonesim modem will quit with the remote disconnect detection patc=
h   =


Details
-------------------------------
The every checkpoint would be one or more test case to cover and result is =
for functionality, besides you may find some functional limitation in comme=
nts.

Features				checkpoints		result		comments

Call history			Missed call		pass
					Outgoing call		pass
					Incoming call		pass
					Duration			pass
					Date				pass
SMS					Send/receive		pass			Enhancement bug #8898
					Different class	pass
					Character set		pass
					Set Center add	pass
					More segments		pass
Voice call			Dial				pass
					Accept/reject		pass
					Hold/Retrieve		pass
					Release			pass
					ECT				pass
Multiparty call		Create			pass
					Hangup			pass
					Private chat		pass
					Hold				pass
Sim phonebook			Read				pass
					Character set		pass
					vCard3.0 			pass
SS					CF				pass
					CB				pass
					CW				pass
					CLIP/CLIR			pass
Setting				AOC				pass
					CF/CW/CB			pass
GSM string			General strings	pass
					USSD				pass
Modem 				Basic information	pass
					Two modems		pass		Low priority bug #9370
					Abnormal quit		fail		#9371,#8185
Networking			Basic information	pass
					Signal indicator	pass
Sim file				Read IMSI			pass
					Read MSISDN		pass
					Emergence number	pass
					SDN number		pass
Cell broadcast		Receive one		pass
					Character set		pass		Enhancement bug #9453
					Receive more char	fail		Fixed now, bug #9374
Call Volume			Get/Set value		pass
					Mute/Unmute		pass
Message history		Send				pass
					Receive			pass
					Unsend			pass
					Date				pass
HPF					Dial a call		pass
					Hangup			pass
					DTMF				pass
					Hold/retrieve		pass
					Multiparty call	pass
GPRS					Register 			pass
					Create context	pass
					Active context	pass
					Deactivate context	pass
					Set/Get APN		pass


-----------------------------------------------
Thanks
Zhigang


--===============8794060853832940299==--

