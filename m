Content-Type: multipart/mixed; boundary="===============8396259309322503466=="
MIME-Version: 1.0
From: Fu, Elva <elva.fu@intel.com>
Subject: light test report for oFono v0.26
Date: Fri, 13 Aug 2010 11:56:24 +0800
Message-ID: <1A42CE6F5F474C41B63392A5F80372B2290E5D52@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <B32E3D5F1713054290B4FF257B89C51A10A0098251@shsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8396259309322503466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Test Objective
--------------------------------------
This is regular light testing for oFono upstream release. During this round=
 of testing, we mainly focus on new feature testing to ensure new features =
work well and regression testing to ensure no big regression.

Test Environment
-------------------------------
General PC:
	pre-installed FC12)
    oFono v0.26 =

    Phonesim 1.4 =

Huawei E160G Modem, 1552 Modem =

UNICOM 3G sim card
UNICOM WCDMA network env

Test Coverage
-------------------------------
The testing is based on phonesimv1.4 and covered most of implemented featur=
es in v0.26 (Call history, SMS, Voice call, Multiparty call, Sim Phonebook,=
 SS, Setting, GSM string, USSD, Modem, Voice mail, Networking, SIM file, Ce=
ll broadcast, Call volume, Message history, HFP, GPRS, Modem Emualtor) =

"ppp" and "sms delivery report" features testing are also included in this =
round of testing. =


Test Result Summary
-------------------------------
Total executed total 311 test cases during this round of testing, and among=
 them: =

		Pass:    308
		Fail:     3
	Most functionalities work well. we reported 2 new bug and No regression is=
 detected out.

"ppp": it works well. user can setup connection; disconnect the connection.=
 website access and ftp upload/download work well. Sometimes oFono v0.25 wi=
ll crash when disconnecting ppp, but the issue is fixed quickly in ofono v0=
.26 :-)

"Sms delivery report": most functionalities work well and more stable. User=
 can enable/disable delivery report, get/set sms bearer, get delivery repor=
t after sending sms successfully. However, rp -error of sms is not tested f=
or it is hard to test it in real network. =


Issue Summary
-------------------------------
New bugs:
Bug 5193 - the attached status did not update after power off GPRS radio
Bug 4081- Cannot get sms delivery status without international number

Main Open bugs:
Bug 8898 -  spend long time on getting fail report of sms  =

Bug 872 - Cannot deactivate all contexts
Bug 5193 - the attached status did not update after power off GPRS radio
Bug 5117- Crash when receiving unsolicited "+CREG: 0"
Bug 389 - 3G modem fail to work after disable/enable the 3G device in ConnM=
an
Bug 5193 - the attached status did not update after power off GPRS radio
Bug 4081- Cannot get sms delivery status without international number
Bug 4001 - Segfault in ofono_modem_driver_unregister
Bug 3971 - Cannot set Voice No reply timeout value in CF
Bug 2078 - 3G network service sometimes fail to come out after swtich off/o=
n 3G device  =

Bug 868 - ussd notification display is incorrect with UCS2 character set

Detailed Test Results:
-------------------------------
to make it more readable, we summarized by feature list. :-)

Features       checkpoints               test results       comments
Call history		Missed call				pass				=

				Outgoing call				pass				=

				Incoming call				pass				=

				Duration					pass				=

				Date					pass				=

SMS				Send/receive				pass            =

				Class0, 1					pass				=

				Set service center address	pass				=

				More segments			pass				=

				Different character set		pass				=

Voice call			Dial						pass				=

				Accept					pass				=

				Reject					pass				=

				Hold						pass				=

				Retrieve					pass				=

				Release					pass				=

				ECT						pass				=

Multiparty call		Create					pass				=

				Hang up					pass				=

				Private chat				pass				=

				Hold						pass				=

Sim Phonebook	Read					pass				=

				Different character set		pass				=

				Vcard3.0					pass				=

SS				CF						pass				=

				CB						pass 			=

				CW						pass				=

				CLIR/CLIP				pass				=

Setting			AOC						pass				=

				CF/CB					pass				=

GSM string		General strings			pass				=

				USSD					pass				=

USSD			Send					pass				=

				Cancel request			pass				=

				Respond					pass				=

				Different character set		fail				#868
Modem			Basic function				pass				=

				Two modems				pass				=

Voice mail		Get/Set number			pass				=

				Message Count			pass				=

				Notification				pass				=

				CPHS information			pass				=

Networking		Basic network information	pass				=

				Signal indicator			pass				=

				Scan						pass				=

				Register					pass				=

SIM file			Read IMSI				pass				=

				Read/set MSISDN			pass				=

				Read Emergency number	pass				=

				Read SDN number			pass				=

				PIN code					pass				=

				PUK						pass				=

Cell broadcast		Receive a CB message		pass				=

				Receive several CB messages pass			=

				Receive more pages CB message pass         =

				Different language 		pass				=

Call volume		Set/get volume			pass				=

				Mute/unmute				pass				=

Message history	Send history				pass				=

				Receive history			pass				=

				Date					pass				=

HFP				Voice call					pass				=

				Multiparty call				pass				=

				Networking				pass				=

				Call volume				pass				=

				Audio control				pass				=

GPRS			Active context				pass				=

				Edit profiles				pass				=

				Deactivate context			pass				=

				Deactivate all context		fail				#872
				Detach					pass				=

				Attach					pass				=

				Create context			pass				=

				Remove context			pass				=

Modem Emualtor	Basic AT command			pass				=

ppp				connect/disconnect		pass	=

				webpage access			pass	=

				ftp upload/download		pass	=

sms delivery report	enable/disable delivery report pass	=

				get/Set sms bearer			pass	=

				get fail/successful delivery report	fail	(basically works except for #4=
081)

Thanks
Elva

--===============8396259309322503466==--

