Content-Type: multipart/mixed; boundary="===============6317409661725192891=="
MIME-Version: 1.0
From: Alexander Kanavin <alexander.kanavin@nokia.com>
Subject: [PATCH] Document the SS control string API
Date: Wed, 13 Oct 2010 14:33:38 +0300
Message-ID: <1286969618-3558-1-git-send-email-alexander.kanavin@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6317409661725192891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/supplementaryservices-api.txt |   95 +++++++++++++++++++++++++++++++++=
++-
 1 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/doc/supplementaryservices-api.txt b/doc/supplementaryservices-=
api.txt
index 5ef123e..d80770a 100644
--- a/doc/supplementaryservices-api.txt
+++ b/doc/supplementaryservices-api.txt
@@ -7,15 +7,104 @@ Object path	[variable prefix]/{modem0,modem1,...}
 =

 Methods		string, variant Initiate(string command)
 =

-			Sends a USSD command string to the network
-			initiating a session.  When the request is handled
+			If the command is a recognized supplementary service =

+			control string, the corresponding SS request is made and
+			the result is returned.
+
+			Otherwise the command is sent to the network initiating a =

+			USSD session. When the request is handled
 			by the appropriate node of the network, the
 			method returns the response or an appropriate
-			error.  The network may be awaiting further response
+			error. The network may be awaiting further response
 			from the ME after returning from this method and no
 			new command can be initiated until this one is
 			cancelled or ended.
 =

+			The first return argument and the corresponding =

+			second return argument are:
+
+			"USSD"				string ussd_response
+			"CallBarring"			(string ss_op, string cb_service, dict cb_dict)
+			"CallForwarding"		(string ss_op, string cf_service, dict cf_dict)
+			"CallWaiting"			(string ss_op, dict cw_dict)
+			"CallingLinePresentation"	(string ss_op, string status)
+			"CalledLinePresentation"	(string ss_op, string status)
+			"CallingLineRestriction"	(string ss_op, string clir_status)
+			"CalledLineRestriction"		(string ss_op, string status)
+
+			ss_op contains the supplementary service operation:
+
+			"activation"
+			"registration"
+			"interrogation"
+			"deactivation"
+			"erasure"
+			=

+			cb_service contains the call barring service for =

+			which the operation was requested:
+			=

+			"AllOutgoing"
+			"InternationalOutgoing"
+			"InternationalOutgoingExceptHome"
+			"AllIncoming"
+			"IncomingWhenRoaming"
+			"AllBarringServices"
+			"AllOutgoingServices"
+			"AllIncomingServices"
+			=

+			cf_service contains the call forwarding service for =

+			which the operation was requested:
+
+			"Unconditional"
+			"Busy"
+			"NoReply"
+			"NotReachable"
+			"All"
+			"AllConditional"
+			=

+			cb_dict contains basic service/call barring =

+			service combinations that were affected by SS operation and =

+			their current status ("enabled" or "disabled"). The basic services are:
+
+			"Voice"
+			"Data"
+			"Fax"
+			"Sms"
+			"DataSync"
+			"DataAsync"
+			"DataPad"
+			"DataPacket"
+			=

+			To those the name of call barring service is appended, so the property =
and value
+			is for example:
+			=

+			"FaxIncomingWhenRoaming" : "disabled"
+			=

+			cf_dict contains call forwarding properties affected by the operation. =

+			Propery names are formed from basic service name and call forwarding =

+			service name, for example:
+			=

+			"VoiceNoReply" : "+12345678"
+			=

+			The property value is the phone number to which the call is forwarded.
+			=

+			For "NoReply" service, there is also a timeout property, holding the ti=
meout
+			in seconds, for example:
+			=

+			"VoiceNoReplyTimeout" : 20
+
+			cw_dict contains basic services with "CallWaiting" suffix that were aff=
ected =

+			by call waiting operation and their current status ("enabled" or "disab=
led"), =

+			for example:
+			=

+			"VoiceCallWaiting" : "enabled"
+			=

+			status can be "disabled" or "enabled".
+			clir_status can be "disabled", "permanent", "on" or "off".
+
+			More information about supplementary services is provided in =

+			call-barring-api.txt, call-forwarding-api.txt and call-settings-api.txt
+
 			Possible Errors: [service].Error.Timedout
 			Possible Errors: [service].Error.Canceled
 =

-- =

1.7.1


--===============6317409661725192891==--

