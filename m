Content-Type: multipart/mixed; boundary="===============1610990511461622059=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] doc: Add 2G GCF test plan for certification
Date: Mon, 06 Aug 2012 17:34:21 +0200
Message-ID: <1344267261-28317-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1344267261-28317-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1610990511461622059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/gcf-testplan-gsm.txt | 5180 ++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 5180 insertions(+), 0 deletions(-)
 create mode 100644 doc/gcf-testplan-gsm.txt

diff --git a/doc/gcf-testplan-gsm.txt b/doc/gcf-testplan-gsm.txt
new file mode 100644
index 0000000..c1f568c
--- /dev/null
+++ b/doc/gcf-testplan-gsm.txt
@@ -0,0 +1,5180 @@
+This document is extracted from the Conformance Assessment Table version
+3.45.1_20120414_r030.
+
+Purpose
+=3D=3D=3D=3D=3D=3D=3D
+The purpose of this document is to list all the relevant 2G GCF and not GCF
+test cases but still applicable to oFono.
+Each test case are described regarding the pre-condition requirement, the
+steps to execute (preferably in the form of test scripts) and the expected
+outcome.
+
+
+2G Test cases - 3GPP 51.010-1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+
+26.8.1.2.4.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Outgoing call / U3 MS originating call proceeding / PROGRESS received with=
out
+in band information
+
+Steps to execute
+./dial-number 0123456902
+
+Expected Result
+-call is dialing
+-notification +XPROGRESS: 1,7 should be received i.e. TCH now available,
+in-band tones yet indicated not to be available.
+
+
+
+26.8.1.2.4.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Outgoing call / U3 MS originating call proceeding / PROGRESS with in band
+information
+
+Steps to execute
+./dial-number 0123456902
+
+Expected Result
+-call is dialing
+-notification +XPROGRESS: 1, 3 should be received i.e. in-band tones avail=
able.
+
+
+26.8.1.2.4.5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Outgoing call / U3 MS originating call proceeding / DISCONNECT with in band
+tones
+
+Steps to execute
+./dial-number 0123456902
+
+Expected Result
+-call is dialing
+-notification +XPROGRESS: 1,3 should be received i.e. in-band tones availa=
ble.
+-notification +XPROGRESS: 1,11 should be received i.e. last speech call has
+been ended and speech can be disabled.
+
+
+26.8.1.2.4.6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Outgoing call / U3 MS originating call proceeding / DISCONNECT without in =
band
+tones
+
+Steps to execute
+./dial-number 0123456902
+
+Expected Result
+-call is dialing
+-notification +XPROGRESS: 1,0 should be received i.e. in-band-tones are not
+available or no information about that is present.
+-notification +XPROGRESS: 1,11 should be received i.e. last speech call has
+been ended and speech can be disabled.
+
+
+26.8.1.2.4.13
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Outgoing call / U3 MS originating call proceeding / Internal alerting
+indication
+
+Steps to execute
+./dial-number 0123456902
+
+Expected Result
+-call is dialing
+-call is alerting after prompt confirmation
+
+
+26.8.1.2.5.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Outgoing call / U4 call delivered / DISCONNECT with in band tones
+
+Steps to execute
+./dial-number 0123456902
+
+Expected Result
+-call is dialing then alerting
+-notification +XPROGRESS: 1,3 should be received i.e. in-band tones availa=
ble.
+-notification +XPROGRESS: 1,11 should be received i.e. last speech call has
+been ended and speech can be disabled.
+
+
+26.8.1.2.6.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+U10 call active / DISCONNECT with in band tones
+
+Steps to execute
+./dial-number 0123456902
+
+Expected Result
+-call is dialing, alerting then active after prompt confirmation
+-notification +XPROGRESS: 1,3 should be received i.e. in-band tones availa=
ble.
+-notification +XPROGRESS: 1,11 should be received i.e. last speech call has
+been ended and speech can be disabled.
+
+
+26.8.1.3.5.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Incoming call / U8 connect request / DISCONNECT received with in-band
+information
+
+Steps to execute
+./answer-calls
+
+Expected Result
+-notification +XPROGRESS: 1,3 should be received i.e. in-band tones availa=
ble.
+-incoming call enters in U12 state then it is disconnected (reason remote)
+
+
+26.8.1.3.5.5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Incoming call / U8 connect request / DISCONNECT received without in-band
+information
+
+Steps to execute
+./answer-calls
+
+Expected Result
+-notification +XPROGRESS: 1,0 should be received i.e. in-band tones not
+available.
+-incoming call enters in U19 state then it is disconnected (reason remote)
+
+
+26.8.1.4.3.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+In-call functions / Channel changes / A successful channel change in active
+state / Handover and Assignment Command
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+26.8.1.4.3.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+In-call functions / Channel changes / An unsuccessful channel change in ac=
tive
+mode / Handover and Assignment Command
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+26.8.1.4.5.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+In-call functions / MS originated in-call modification / A successful case=
 of
+modifying
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+26.8.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D
+Call Re-establishment / Call Present, re-establishment allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+26.8.2.2
+=3D=3D=3D=3D=3D=3D=3D=3D
+Call Re-establishment / Call Present, re-establishment not allowed
+
+Steps to execute
+./dial-number 0123456902
+
+Expected Result
+-call is dialing, alerting then active
+-call is disconnected (reason remote)
+
+
+26.8.2.3
+=3D=3D=3D=3D=3D=3D=3D=3D
+Call Re-establishment / Call under establishment, transmission stopped
+
+Steps to execute
+./dial-number 0123456902
+
+Expected Result
+-call is dialing then alerting
+-call is disconnected (reason remote)
+
+
+26.8.3
+=3D=3D=3D=3D=3D=3D
+User to user signalling
+
+Steps to execute
+./answer-calls
+
+Expected Result
+-incoming call becomes active then it is disconnected (reason remote)
+
+
+26.9.2
+=3D=3D=3D=3D=3D=3D
+Structured procedures / MS originated call / early assignment
+
+Steps to execute
+./dial-number 0123456902
+./dial-number 0123456902
+
+Expected Result
+-call is dialing then alerting after prompt confirmation
+-call is active after prompt confirmation
+-call is disconnected (reason remote)
+-second call is dialing then alerting after prompt confirmation
+-call is active after prompt confirmation
+-call is disconnected (reason remote)
+
+26.9.3
+=3D=3D=3D=3D=3D=3D
+Structured procedures / MS originated call / late assignment
+
+Steps to execute
+./dial-number 0123456902
+./dial-number 0123456902
+
+Expected Result
+-call is dialing then alerting after prompt confirmation
+-call is active after prompt confirmation
+-call is disconnected (reason remote)
+-second call is dialing then alerting after prompt confirmation
+-call is active after prompt confirmation
+-call is disconnected (reason remote)
+
+
+26.9.4
+=3D=3D=3D=3D=3D=3D
+Structured procedures / MS terminated call / early assignment
+
+Steps to execute
+./answer-calls
+./hangup-all
+./answer-calls
+./hangup-all
+
+Expected Result
+-incoming call is alerting after prompt confirmation
+-call is connected after prompt confirmation
+-call is active then disconnected (reason remote)
+-second incoming call is alerting after prompt confirmation
+-call is connected after prompt confirmation
+-call is active then disconnected (reason remote)
+
+
+26.9.5
+=3D=3D=3D=3D=3D=3D
+Structured procedures / MS terminated call / late assignment
+
+Steps to execute
+./answer-calls
+./answer-calls
+
+Expected Result
+-incoming call is alerting after prompt confirmation
+-call is connected after prompt confirmation
+-call is active then disconnected (reason remote)
+-incoming call is alerting after prompt confirmation
+-call is connected after prompt confirmation
+-call is active then disconnected (reason remote)
+
+
+26.9.6.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Structured procedures / emergency call / idle updated / preferred channel =
rate
+
+Steps to execute
+./dial-number 112
+
+Expected Result
+-call is connected then active after prompt confirmation
+-call is disconnected (reason remote)
+
+
+26.9.6.1.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Structured procedures / emergency call / idle updated, non-preferred chann=
el
+rate
+
+Steps to execute
+./dial-number 112
+
+Expected Result
+-call is connected then active after prompt confirmation
+-call is disconnected (reason remote)
+
+
+26.9.6.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Structured procedures / emergency call / idle, no IMSI / accept case
+
+Steps to execute
+-Turn mobile OFF
+-Remove SIM Card from device
+-Turn Mobile ON
+-./online-modem
+-./dial-number 112
+
+Expected Result
+-emergency call is dialing then disconnected (reason remote)
+
+
+26.9.6.2.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Structured procedures / emergency call / idle, no IMSI / reject case
+
+Steps to execute
+-Turn mobile OFF
+-Remove SIM Card from device
+-Turn Mobile ON
+-./online-modem
+-./dial-number 112
+
+Expected Result
+-emergency call is dialing then disconnected (reason remote)
+
+
+26.9.6a.1.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Test Call using eCall capable MS with "eCall only" subscription on USIM
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+26.9.6a.1.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Manually initiated eCall using eCall capable MS with "eCall only" subscrip=
tion
+on USIM
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+26.9.6a.1.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Manually initiated eCall using eCall capable MS with eCall capable USIM
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+26.9.6a.1.5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+eCall Inactivity State after  T3242 expires
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+26.9.6a.1.6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Automatically initiated eCall
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+26.9.6a.1.7
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Reconfiguration Call using eCall capable MS with =E2=80=98eCall only=E2=80=
=99 subscription
+on USIM
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.19
+=3D=3D=3D=3D=3D
+Phase identification
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.20
+=3D=3D=3D=3D=3D
+SIM presence detection
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.1.1.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CLIP, Normal operation
+
+Steps to execute
+-
+
+Expected Result
+Incoming call shall be displayed with Line Identification
+
+
+31.1.1.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CLIP, Interrogation accepted
+
+Steps to execute
+./test-ss *#30#
+
+
+Expected Result
+CLIP SS should be interrogated successfully:
+CallingLinePresentation : Operation [ activation ] Status [ disabled ]
+
+
+31.1.1.2.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CLIP, Interrogation rejected
+
+Steps to execute
+./dial-number 123
+./test-ss *#30#
+./test-ss *#30#
+
+Expected Result
+1- Does the MMI correctly display the response regarding the unsuccessfull=
 CLIP
+interrogation (All Basic Services)?
+ofonod[442]: Aux: > AT+CLIP?\r
+ofonod[442]: Aux: < \r\n+CLIP: 0,2\r\n
+CallingLinePresentation : Operation [ activation ] Status [ unknown ]
+
+2- Does the MMI correctly display the response regarding the rejection of =
CLIP
+interrogation (All Basic Services)?
+ofonod[516]: Aux: > AT+CLIP?\r
+ofonod[516]: Aux: < \r\n+CLIP: 0,2\r\n
+CallingLinePresentation : Operation [ activation ] Status [ unknown ]
+
+
+31.1.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D
+CLIR, Normal operation - requesting presentation of CLI
+
+Steps to execute
+./dial-number 123 disabled
+
+Expected Result
+Caller line identification should be displayed on remote side.
+There is no way to check that caller line identification is displayed.
+
+
+31.1.2.2
+=3D=3D=3D=3D=3D=3D=3D=3D
+CLIR, Normal operation - requesting restriction of CLI presentation
+
+Steps to execute
+./dial-number 123 enabled
+
+Expected Result
+Caller line identification should be hidden on remote side.
+There is no way to check that caller line identification is hidden.
+
+
+31.1.2.3.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CLIR, Interrogation accepted
+
+Steps to execute
+./test-ss *#31#
+
+Expected Result
+CLIR SS should be interrogated successfully:
+CallingLineRestriction : Operation [ interrogation ] Status [ disabled ]
+
+
+31.1.2.3.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CLIR, Interrogation rejected
+
+Steps to execute
+./dial-number 123
+./test-ss *#31#
+./test-ss *#31#
+
+Expected Result
+1- Does the MMI correctly display the response regarding the unsuccessful =
CLIR
+interrogation (All Basic Services)?
+ofonod[600]: Aux: > AT+CLIR?\r
+ofonod[600]: Aux: < \r\n+CLIR: 2,2\r\n
+CallingLineRestriction : Operation [ interrogation ] Status [ unknown ]
+
+2- Does the MMI correctly display the response regarding the rejection of =
CLIR
+interrogation (All Basic Services)?
+ofonod[600]: Aux: > AT+CLIR?\r
+ofonod[600]: Aux: < \r\n+CLIR: 2,2\r\n
+CallingLineRestriction : Operation [ interrogation ] Status [ unknown ]
+
+
+31.2.1.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call forwarding supplementary services, Registration accepted
+
+Steps to execute
+./test-ss **61*00431234*11*5#
+
+Expected Result
+-
+
+
+31.2.1.1.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call forwarding supplementary services, Registration rejected
+
+Steps to execute
+./dial-number 123
+./test-ss **67*00431234*21#
+./test-ss **002*00431234*13#
+
+Expected Result
+Both registration should fail:
+1- Has there been an error in registration of call forwarding service for =
CFB
+(all synchronous services)?
+ofonod[591]: Aux: > AT+CCFC=3D1,3,"00431234",129,160\r
+ofonod[591]: Aux: < \r\n+CME ERROR: 4\r\n
+Unable to perform operation:  org.ofono.Error.NotSupported: Operation is n=
ot
+supported by the network / modem
+
+2- Has the registration of call forwarding (CF) for all Facsimilie services
+been rejected by the network?
+ofonod[591]: Aux: > AT+CCFC=3D4,3,"00431234",129,4,,,20\r
+ofonod[591]: Aux: < \r\n+CME ERROR: 3\r\n
+Unable to perform operation:  org.ofono.Error.NotAllowed: Operation is not
+allowed
+
+
+31.2.1.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call forwarding supplementary services, Erasure accepted
+
+Steps to execute
+./test-ss "##004**13#"
+
+Expected Result
+-
+
+
+31.2.1.2.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call forwarding supplementary services, Erasure rejected
+
+Steps to execute
+./test-ss "##21**11#"
+./test-ss "##61**13#"
+
+Expected Result
+1- Has the appropriate user indication been displayed for registration of =
call
+forwarding unconditional (CFU) for all speach services.Error message on MS
+Service not allowed?
+ofonod[569]: Aux: > AT+CCFC=3D0,4,,,1\r
+ofonod[569]: Aux: < \r\n+CME ERROR: 4\r\n
+Unable to perform operation:  org.ofono.Error.NotSupported: Operation is n=
ot
+supported by the network / modem
+
+2- Has the registration of erasure of call forwarding on no reply (CFNRy) =
for
+all basic services been rejected by the network?
+ofonod[569]: Aux: > AT+CCFC=3D2,4,,,4\r
+ofonod[569]: Aux: < \r\n+CME ERROR: 3\r\n
+Unable to perform operation:  org.ofono.Error.NotAllowed: Operation is not
+allowed
+
+
+
+31.2.1.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call forwarding supplementary services, Activation
+
+Steps to execute
+./test-ss *002**22#
+./test-ss *21#
+
+Expected Result
+-
+
+
+31.2.1.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call forwarding supplementary services, Deactivation
+
+Steps to execute
+./test-ss "#004**11#"
+./test-ss "#62**13#"
+
+
+Expected Result
+-
+
+
+31.2.1.6.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call forwarding supplementary services, Interrogation accepted
+
+Steps to execute
+./test-ss *#67#
+./test-ss "*#61**11#"
+
+Expected Result
+Interrogation should return CFB status:
+CallForwarding : Operation [ interrogation ] Service Type [ Busy ]
+DataAsyncBusy :
+VoiceBusy :
+FaxBusy :
+DataSyncBusy :
+SmsBusy :
+
+
+31.2.1.6.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call forwarding supplementary services, Interrogation rejected
+
+Steps to execute
+./test-ss *#62#
+./test-ss *#67**13#
+
+Expected Result
+-
+
+
+31.2.1.7.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call forwarding supplementary services, Notification during an incoming ca=
ll
+
+Steps to execute
+./answer-calls
+
+Expected Result
+Should received before answering call:
+ofonod[591]: Voice: < \r\n+CSSU: 10\r\n
+After call is anwered:
+ofonod[591]: Voice: < \r\n+CSSU: 10\r\n
+
+
+31.2.1.7.1.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call forwarding supplementary services, Notification during an outgoing ca=
ll
+
+Steps to execute
+./dial-number 123
+
+Expected Result
+Should receive after having dialed:
+ofonod[566]: Voice: < \r\n+CSSI: 0\r\n
+then
+ofonod[566]: Voice: < \r\n+CSSI: 1\r\n
+
+
+31.2.1.7.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call forwarding supplementary services, Forwarded-to mobile subscriber side
+
+Steps to execute
+-
+
+Expected Result
+Should received ofonod[566]: Voice: < \r\n+CSSU: 0\r\n
+
+
+31.3.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Waiting, Waiting call indication and confirmation
+
+Steps to execute
+./answer-calls
+
+Expected Result
+After answering call, the MS shall indicate the existence of the waiting c=
all
+to the user using this notification:
+In ofono.log Voice: < \r\n+XCALLSTAT: 2,5\r\n\r\n+CCWA: "",129,1,,0\r\n
+Voicecall02 should also have "State =3D waiting" in monitor.log
+
+
+31.3.1.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Waiting, Waiting call accepted; existing call released
+
+Steps to execute
+./release-and-answer
+
+Expected Result
+According to monitor.log:
+After answering voicecall01, its state is active.
+Another call is in waiting state voicecall02.
+voicecall01 should be released properly and voicecall02 should be answered=
 and
+its state should be active.
+
+
+31.3.1.2.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Waiting, Waiting call accepted; existing call on hold, no additional =
calls
+
+Steps to execute
+./hold-and-answer
+
+Expected Result
+1st call should be put in held state.
+Waiting call should be answered and in active state.
+
+
+31.3.1.2.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Waiting, Existing call released by user A; waiting call accepted
+
+Steps to execute
+./answer-calls
+./answer-calls
+
+Expected Result
+After first call is answered, it is in state disconnected.
+Waiting call should be answered correctly and in active state.
+
+
+31.3.1.3.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Waiting, Waiting call released by subscriber B
+
+Steps to execute
+./answer-calls
+./hangup-call /ifx_0/voicecall02
+
+Expected Result
+After answering 1st call, 2nd waiting call should be cleared.
+1st should still be active after waiting call clearing.
+
+
+31.3.1.3.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Waiting, Waiting call released by calling user C
+
+Steps to execute
+./answer-calls =

+
+Expected Result
+After answering first call, a voicecall in waiting state is added.
+Remote user clears waiting call, we should be informed the waiting call has
+been released because it is in disconnected state.
+
+
+31.3.1.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Waiting, Activation
+
+Steps to execute
+./test-ss *43*22#
+./test-ss *43#
+
+Expected Result
+-
+
+
+31.3.1.5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Waiting, Deactivation
+
+Steps to execute
+./test-ss "#43*13#"
+./test-ss "#43#"
+
+Expected Result
+-
+
+
+31.3.1.6.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Waiting, Interrogation accepted
+
+Steps to execute
+./test-ss "*#43#"
+./test-ss "*#43#"
+
+Expected Result
+After first interrogation:
+CallWaiting : Operation [ interrogation ]
+DataSyncCallWaiting : enabled
+SmsCallWaiting : disabled
+FaxCallWaiting : disabled
+DataAsyncCallWaiting : disabled
+VoiceCallWaiting : disabled
+After second interrogation:
+CallWaiting : Operation [ interrogation ]
+DataSyncCallWaiting : disabled
+SmsCallWaiting : disabled
+FaxCallWaiting : disabled
+DataAsyncCallWaiting : disabled
+VoiceCallWaiting : disabled
+
+
+31.3.1.6.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Waiting, Interrogation rejected
+
+Steps to execute
+./answer-calls
+./test-ss *#43# (+CME ERROR: 3)
+./test-ss *#43# (+CME ERROR:4)
+
+Expected Result
+Should be rejected by network twice
+
+
+31.3.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Hold, Hold invocation
+
+Steps to execute
+./dial-number 123
+./swap-calls
+./swap-calls
+
+Expected Result
+After first try, hold request should fail:
++CME ERROR 4
+After 2nd try, hold request should be completed successfully:
+{VoiceCall} [/ifx_0/voicecall01] State =3D held
+
+
+31.3.2.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Hold, Retrieve procedure
+
+Steps to execute
+./dial-number 123
+./swap-calls (hold call)
+./swap-calls (try to retrieve)
+./swap-calls (try to retrieve)
+
+Expected Result
+1st hold retrieve should fail:
++CME ERROR 4
+2nd hold retrieve should be successful:
+{VoiceCall} [/ifx_0/voicecall01] State =3D active
+
+
+31.3.2.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call Hold, Alternate from one call to the other
+
+Steps to execute
+./answer-calls
+./hold-and-answer =

+./swap-calls
+./swap-calls (+CME ERROR 4)
+
+Expected Result
+After 1st call swapping, voicecall01 should be in state held and voicecall=
02
+should be in state active.
+After 2nd call swapping, voicecall02 should be in state held and voicecall=
01
+should be in state active.
+
+
+31.4.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Beginning the MultiParty service, successful case
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+
+Expected Result
+After creating multiparty, both call should property multiparty =3D true in
+monitor.log.
+
+
+31.4.1.2
+=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Beginning the MultiParty service, unsuccessful case
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./create-multiparty
+
+Expected Result
+Creating multiparty call should fail twice, there should be twice in ofono=
.log:
+ofonod[511]: Voice: > AT+CHLD=3D3\r
+ofonod[511]: Voice: < \r\n+CME ERROR: 100\r\n
+
+
+31.4.1.3
+=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Beginning the MultiParty service, expiry of timer T(BuildMPTY)
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+
+Expected Result
+Creating multiparty should fail because of network timeout i.e. in ofono.l=
og:
+ofonod[549]: Voice: > AT+CHLD=3D3\r
+ofonod[549]: Voice: < \r\n+CME ERROR: 31\r\n (network timeout)
+
+
+31.4.2.1.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing an active MultiParty call, Put the MultiParty call on
+hold, successful case
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./swap-calls
+
+Expected Result
+Multiparty calls should be set in state =3D held according to monitor.log
+
+
+31.4.2.1.1.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing an active MultiParty call, Put the MultiParty call on
+hold, unsuccessful case
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./swap-calls
+./swap-calls
+
+Expected Result
+Both hold try should fail with +CME ERROR: 100 according to ofono.log
+
+
+31.4.2.1.1.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing an active MultiParty call, Put the MultiParty call on
+hold, expiry of timer T(HoldMPTY)
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./swap-calls
+
+Expected Result
+Putting MPTY call in hold should fail because of network timeout i.e. in
+ofono.log:
+ofonod[549]: Voice: > AT+CHLD=3D6\r
+ofonod[549]: Voice: < \r\n+CME ERROR: 31\r\n (network timeout)
+
+
+31.4.2.1.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing an active MultiParty call, Create a private communica=
tion
+with one of the remote parties, successful case
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./private-chat /ifx_0/voicecall01
+
+Expected Result
+While private chatting with call 1, call 2 should be put in held state
+according to monitor.log
+
+
+31.4.2.1.2.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing an active MultiParty call, Create a private communica=
tion
+with one of the remote parties, unsuccessful case
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./private-chat /ifx_0/voicecall01
+./private-chat /ifx_0/voicecall01
+
+Expected Result
+Private chatting call 1 should fail twice, there should be twice in ofono.=
log:
+ofonod[559]: Voice: > AT+CHLD=3D21\r
+ofonod[559]: Voice: < \r\n+CME ERROR: 4\r\n
+
+
+31.4.2.1.2.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing an active MultiParty call, Create a private communica=
tion
+with one of the remote parties, expiry of timer T(SplitMPTY)
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./private-chat /ifx_0/voicecall01
+
+Expected Result
+Private chatting call 1 should fail because of network timeout i.e. in
+ofono.log:
+ofonod[505]: Voice: > AT+CHLD=3D21\r
+ofonod[505]: Voice: < \r\n+CME ERROR: 31\r\n
+
+
+
+31.4.2.1.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing an active MultiParty call, Terminate the entire Multi=
Party
+call
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./hangup-active =

+
+Expected Result
+All party should be released from the call.
+
+
+31.4.2.1.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing an active MultiParty call, Explicitly disconnect a re=
mote
+party
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+
+Expected Result
+The specified remote party should be disconnected from the multiparty call
+
+
+31.4.2.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Remote parties, Release from the MultiParty call
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+
+Expected Result
+The multiparty call should be ended successfully.
+
+
+31.4.3.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing a held MultiParty call, Retrieve the held MultiParty
+call, successful case
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./swap-calls
+./swap-calls
+
+Expected Result
+Multiparty call should be retrieved successfully according to monitor.log:
+{VoiceCall} [/ifx_0/voicecall01] State =3D held
+{VoiceCall} [/ifx_0/voicecall02] State =3D held
+{VoiceCall} [/ifx_0/voicecall01] State =3D active
+{VoiceCall} [/ifx_0/voicecall02] State =3D active
+
+
+31.4.3.1.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing a held MultiParty call, Retrieve the held MultiParty
+call, unsuccessful case
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./swap-calls
+./swap-calls
+./swap-calls
+
+Expected Result
+Retrieving multiparty call should fail twice, there should be in ofono.log:
+ofonod[544]: Voice: > AT+CHLD=3D6\r
+ofonod[544]: Voice: < \r\n+CME ERROR: 4\r\n
+ofonod[544]: Voice: > AT+CHLD=3D6\r
+ofonod[544]: Voice: < \r\n+CME ERROR: 100\r\n
+
+
+31.4.3.1.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing a held MultiParty call, Retrieve the held MultiParty
+call, expiry of timer T(RetrieveMPTY)
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./swap-calls
+./swap-calls
+
+Expected Result
+Retrieving multiparty call should fail because of network timeout i.e. in
+ofono.log:
+ofonod[437]: Voice: > AT+CHLD=3D6\r
+ofonod[437]: Voice: < \r\n+CME ERROR: 31\r\n
+
+
+31.4.3.2
+=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Initiate a new call
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./dial-number 789
+
+Expected Result
+The multiparty call should be put in held state and a new call shall be
+initiated according to monitor.log.
+
+
+31.4.3.3
+=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, TProcess a call waiting request
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./hold-and-answer
+
+Expected Result
+After multiparty all is created, monitor.log should indicated an incoming =
call
+is waiting. Multiparty call should be placed in held state and waiting call
+should answered and active.
+
+
+31.4.3.4
+=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Terminate the held MultiParty call
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./swap-calls
+./hangup-multiparty
+
+Expected Result
+After multiparty call is in held state, it should have been released
+successfully by local user.
+
+
+31.4.4.1.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing a single call and a MultiParty call, Disconnect the
+single call, single call active
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./dial-number 789
+./hangup-active
+
+Expected Result
+The last call should be disconnected by local user, the multiparty call sh=
ould
+be disconnected by remote user according to monitor.log.
+
+
+31.4.4.1.1.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing a single call and a MultiParty call, Disconnect the
+single call, single call held
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./dial-number 789
+./swap-calls
+./hangup-call /ifx_0/voicecall03
+
+
+Expected Result
+After single call has been put in held, the only call disconnected by local
+user should be the held one. Multiparty call should be disconnected by rem=
ote
+user according to monitor.log.
+
+
+31.4.4.1.2.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing a single call and a MultiParty call, Disconnect the M=
PTY,
+clear all parties, MultiParty call held
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./dial-number 789
+./hangup-multiparty
+
+Expected Result
+All the party of the multiparty call should be disconnected by local user,=
 the
+single active call should be disconnected by remote user according to
+monitor.log.
+
+
+31.4.4.1.2.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing a single call and a MultiParty call, Disconnect the M=
PTY,
+clear all parties, MultiParty call active
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./dial-number 789
+./swap-calls
+./hangup-multiparty
+
+Expected Result
+After multiparty call has been place in active state, all the party of the
+multiparty call should be disconnected by local user, the single held call
+should be disconnected by remote user according to monitor.log.
+
+
+31.4.4.2
+=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Managing a single call and a MultiParty call, Disconnect all c=
alls
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./dial-number 789
+./swap-calls
+./hangup-all
+
+Expected Result
+All call should be disconnected by local user according to monitor.log.
+
+
+31.4.4.3.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Add the single call to the MPTY, successful case
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./dial-number 789
+./swap-calls
+./create-multiparty
+
+Expected Result
+Last call should be added to multiparty call successfully i.e. in monitor.=
log:
+{VoiceCall} [/ifx_0/voicecall03] Multiparty =3D True
+
+
+31.4.4.3.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Add the single call to the MPTY, maximum number of participants
+exceeded
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./dial-number 789
+./create-multiparty
+./swap-calls
+./dial-number 321
+./create-multiparty
+
+Expected Result
+Adding the last call to the multiparty call should fail according to ofono=
.log:
+ofonod[577]: Voice: > AT+CHLD=3D3\r
+ofonod[577]: Voice: < \r\n+CME ERROR: 3\r\n
+ofonod[577]: src/voicecall.c:multiparty_create_callback() command failed w=
ith
+error: Operation not allowed
+
+
+31.4.4.4
+=3D=3D=3D=3D=3D=3D=3D=3D
+MultiParty, Alternate between the MPTY call and the single call
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./dial-number 789
+./swap-calls
+./swap-calls
+./swap-calls
+
+Expected Result
+According too monitor.log, UE should alternate to multiparty call and sing=
le
+call in swapping from state =3D held to state =3D active each.
+
+
+31.4.5
+=3D=3D=3D=3D=3D=3D
+MultiParty, Adding extra remote parties
+
+Steps to execute
+./dial-number 123
+./dial-number 456
+./create-multiparty
+./dial-number 789
+./create-multiparty
+
+Expected Result
+Multiparty call should put in held state while initiating the new call and=
 new
+call should be added to the multiparty call according to monitor.log.
+
+
+
+31.8.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D
+Call restriction supplementary services / Registration of a password /
+Registration accepted
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.8.1.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call restriction supplementary services, Registration, Rejection after inv=
oke
+of the RegisterPassword operation
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.8.1.2.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call restriction supplementary services, Registration, Rejection after
+password check with negative result
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.8.1.2.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call restriction supplementary services, Registration, Rejection after new
+password mismatch
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.8.3.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call restriction supplementary services, Rejection after invoke of Activat=
eSS
+operation
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.8.4.1
+=3D=3D=3D=3D=3D=3D=3D=3D
+Deactivation accepted
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.8.4.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call restriction supplementary services, Rejection after invoke of
+DeactivateSS operation
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.8.4.2.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Call restriction supplementary services, Rejection after use of password
+procedure
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.8.6.2
+=3D=3D=3D=3D=3D=3D=3D=3D
+Call restriction supplementary services, Interrogation rejected
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.9.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D
+Mobile station initiated Unstructured supplementary service data operation,
+ProcessUnstructuredSS-request/accepted
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.9.1.2
+=3D=3D=3D=3D=3D=3D=3D=3D
+ProcessUnstructuredSS-request/cross phase compatibility and error handling
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.9.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D
+Network initiated unstructured supplementary service operations,
+UnstructuredSS-Notify/accepted
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.9.2.2
+=3D=3D=3D=3D=3D=3D=3D=3D
+UnstructuredSS-Notify/rejected on user busy
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.9.2.3
+=3D=3D=3D=3D=3D=3D=3D=3D
+UnstructuredSS-Request/accepted
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.10
+=3D=3D=3D=3D=3D
+MMI input for USSD
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.13.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Explicit Call Transfer invocation, successful case, both calls active,
+clearing using DISCONNECT
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.13.1.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Explicit Call Transfer invocation, successful case, second call alerting
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.13.1.5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Explicit Call Transfer invocation, unsuccessful case
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+31.13.1.6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Explicit Call Transfer invocation, expiry of T(ECT)
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+33.6
+=3D=3D=3D=3D
+Subscription Identity management
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+34.2.1
+=3D=3D=3D=3D=3D=3D
+Short message service / SMS point to point - SMS mobile terminated
+
+Steps to execute
+./answer-call or ./hangup-active should be used on the test demand
+
+Expected Result
+SMS should be received in any cases i.e. :
+	- without voicecall active
+	- with voicecall active
+	- after SS call disconnection
+	- after UE call disconnection
+
+
+34.2.2
+=3D=3D=3D=3D=3D=3D
+Short message service / SMS point to point - SMS mobile originated
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+34.2.3
+=3D=3D=3D=3D=3D=3D
+Short message service / SMS point to point - Test of memory full condition=
 and
+memory available notification: (optional for GCF certification if SMS stor=
age
+capacity exceeds 1000 messages)
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+34.2.5.1
+=3D=3D=3D=3D=3D=3D=3D=3D
+Short message class 0 (optional for GCF certification if SMS storage capac=
ity
+exceeds 1000 messages)
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+34.2.5.3
+=3D=3D=3D=3D=3D=3D=3D=3D
+Short message service / Test of message class 0 to 3 - Test of Class 2 Sho=
rt
+Messages
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+34.2.7
+=3D=3D=3D=3D=3D=3D
+Test of the replace mechanism for SM type 1-7
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+34.2.9.1
+=3D=3D=3D=3D=3D=3D=3D=3D
+Multiple SMS mobile originated, MS in idle mode
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+34.2.9.2
+=3D=3D=3D=3D=3D=3D=3D=3D
+Multiple SMS mobile originated, MS in active mode
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+34.3
+=3D=3D=3D=3D
+Short message service cell broadcast
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach procedure/ Normal GPRS attach / GPRS attach / accepted
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach / rejected / IMSI invalid / illegal MS
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach / rejected / IMSI invalid / GPRS services not allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.4-1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach procedure/ Normal GPRS attach / GPRS attach / rejected / PLMN =
not
+allowed / Test procedure 1
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.4-2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach procedure/ Normal GPRS attach / GPRS attach / rejected / PLMN =
not
+allowed / Test procedure 2
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.5-1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach procedure/ Normal GPRS attach / GPRS attach / rejected / roami=
ng
+not allowed in this location area/ procedure 1
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.5-2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach procedure/ Normal GPRS attach / GPRS attach / rejected / roami=
ng
+not allowed in this location area/ procedure 2
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.5-3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach / rejected / roaming not allowed in this location area / proce=
dure
+3
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.5-4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach procedure/ Normal GPRS attach / GPRS attach / rejected / roami=
ng
+not allowed in this location area/ procedure 4
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.6-1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach / abnormal cases / access barred due to access class control /
+Test procedure 1
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.6-2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach / abnormal cases / access barred due to access class control /
+Test procedure 2
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.7
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach / abnormal cases / change of cell into new routing area
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.8
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach / abnormal cases / power off
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.9
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach / abnormal cases / GPRS detach procedure collision
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.1.10
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach / rejected / GPRS services not allowed in this PLMN
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach procedure/ Combined GPRS attach / GPRS and non-GPRS attach
+accepted	=

+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.2.2-1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Combined GPRS attach / GPRS only attach accepted / Test procedure 1
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.2.2-2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Combined GPRS attach / GPRS only attach accepted / Test procedure 2
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.2.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Combined GPRS attach / GPRS attach while IMSI attach
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.2.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Combined GPRS attach / rejected / IMSI invalid / illegal ME
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.2.5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Combined GPRS attach / rejected / GPRS services and non-GPRS services not
+allowed	=

+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.2.6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach procedure/ Combined GPRS attach / Combined GPRS attach / rejec=
ted
+/ GPRS services not allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.2.7
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS attach procedure/ Combined GPRS attach / Combined GPRS attach / rejec=
ted
+/ location area not allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.2.8
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Combined GPRS attach / abnormal cases / attempt counter check / miscellane=
ous
+reject causes
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.1.2.9
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Combined GPRS attach / abnormal cases / GPRS detach procedure collision
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.1.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / accepted
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.1.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / abnormal cases / attempt counter check / procedure timeout
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.1.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / abnormal cases / GMM common procedure collision
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.1.5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach procedure / Combined GPRS detach / power off / accepted
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.1.6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / accepted / GPRS/IMSI detach
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.1.7
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / accepted / IMSI detach
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.1.8
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / abnormal cases / change of cell into new routing area
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.1.9
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / abnormal cases / GPRS detach procedure collision
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / re-attach not required / accepted
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.2.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / rejected / IMSI invalid / GPRS services not allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.2.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / IMSI detach / accepted
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.2.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / re-attach requested / accepted
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.2.5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / rejected / location area not allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+44.2.2.2.6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPRS detach / rejected / GPRS services not allowed in this PLMN
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.2.1.1
+=3D=3D=3D=3D=3D=3D=3D=3D
+PDP context activation / PDP context activation initiated by the mobile
+station / Attach initiated by context activation/QoS Offered by Network is=
 the
+QoS Requested
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.2.1.2.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+PDP context activation / PDP context activation initiated by the mobile
+station /  QoS Offered by Network is a lower QoS / QoS Accepted by MS
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.2.2-1
+=3D=3D=3D=3D=3D=3D=3D=3D
+PDP context activation / PDP context activation requested by the network,
+successful and unsuccessful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.2.2-2
+=3D=3D=3D=3D=3D=3D=3D=3D
+PDP context activation / PDP context activation requested by the network,
+successful and unsuccessful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.2.4.1
+=3D=3D=3D=3D=3D=3D=3D=3D
+T3380 Expiry	=

+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.2.4.2-1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Collision of MS initiated and network requested PDP context activation
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.2.4.2-2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Collision of MS initiated and network requested PDP context activation
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.3.1
+=3D=3D=3D=3D=3D=3D
+PDP context modification procedure (Cases 1 & 2)
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.4.1
+=3D=3D=3D=3D=3D=3D
+PDP context deactivation procedure / PDP context deactivation initiated by=
 the
+MS
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.4.2
+=3D=3D=3D=3D=3D=3D
+PDP context deactivation procedure / PDP context deactivation initiated by=
 the
+network
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.4.3.1
+=3D=3D=3D=3D=3D=3D=3D=3D
+T3390 Expiry
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.4.3.2
+=3D=3D=3D=3D=3D=3D=3D=3D
+Collision of MS and network initiated PDP context deactivation requests
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+45.5.1
+=3D=3D=3D=3D=3D=3D
+Error cases
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+SIM Application Toolkit Test cases - 3GPP 51.010-4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+
+27.22.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+PROFILE DOWNLOAD
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.2
+=3D=3D=3D=3D=3D=3D=3D
+Contents of the TERMINAL PROFILE command
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.3
+=3D=3D=3D=3D=3D=3D=3D
+Servicing of Proactive SIM Commands
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.1.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT normal priority, Unpacked 8 bit data for Text String, screen =
busy
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.1.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, high priority, Unpacked 8 bit data for Text String, successf=
ul
+
+Steps to execute
+-send a display text proactive command to the ME (High priority, unpacked,
+8 bit data)
+-user clears the message
+
+Expected Result
+-the following display text is displayed: "Toolkit Test 2"
+-display text is cleared by user
+
+
+27.22.4.1.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, Packed, SMS default alphabet, successful
+
+Steps to execute
+-send a display text proactive command to the ME (Packed, SMS default alph=
abet)
+-user clears the message
+
+Expected Result
+-the following display text is displayed: "Toolkit Test 3"
+-display text is cleared by user
+
+
+27.22.4.1.1/5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, Clear message after delay, successful
+
+Steps to execute
+-send a display text proactive command to the ME (Clear message after dela=
y)
+
+Expected Result
+-the following display text is displayed: "Toolkit Test 4" then it is clea=
red
+after a delay
+
+
+27.22.4.1.1/7
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, Backward move in SIM session, successful
+
+Steps to execute
+-send a display text proactive command to the ME (Backward move in SIM ses=
sion)
+-user goes back in SIM session
+
+Expected Result
+-the following display text is displayed: "<GO-BACKWARDS>"
+-SIM session goes back to previous menu
+
+
+27.22.4.1.1/8
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, session terminated by user
+
+Steps to execute
+-send a display text proactive command to the ME (session terminated by us=
er)
+-user terminates the SIM session
+
+Expected Result
+-the following display text is displayed: "<ABORT>"
+-SIM session is ended by user
+
+
+27.22.4.1.1/9
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, icon and text to be displayed, no text string given, not
+understood by ME
+
+Steps to execute
+-send a display text proactive command to the ME (icon and text to be
+displayed, no text string given)
+
+Expected Result
+-Command data is not understood by ME
+
+
+27.22.4.1.2/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, no response from user
+
+Steps to execute
+-send a display text proactive command to the ME (Normal priority, no resp=
onse
+from user, unpacked, 8 bit data)
+-user does not send a response
+
+Expected Result
+-the following display text is displayed: "<TIME OUT>"
+-"No response from user" is received within 5 s after the end of that defi=
ned
+period of time
+
+
+27.22.4.1.3/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, display of extension text
+
+Steps to execute
+-send a display text proactive command to the ME (display of extension tex=
t)
+-user clears the message
+
+Expected Result
+-the following display text is displayed: "This command instructs the ME to
+display a text message, and/or an icon (see clause 6.5.4). It  allows the =
SIM
+to define the priority of that message, and the text string format. Two ty=
pes
+of priority are defined:- display normal priority text and/"
+-display text is cleared by user
+
+
+27.22.4.1.4/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, sustained text, unpacked data 8 bits, successful
+
+Steps to execute
+-send a display text proactive command to the ME (Normal priority, unpacke=
d,
+8 bit data)
+
+Expected Result
+-the following display text is displayed: "Toolkit Test 1"
+-SIM session is ended but the text shall sustain until a subsequent proact=
ive
+command is received containing display data.
+
+
+27.22.4.1.4/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, sustained text, clear message after delay, successful
+
+Steps to execute
+-send a display text proactive command to the ME (Clear message after a de=
lay)
+
+Expected Result
+-the following display text is displayed: "Toolkit Test 2"
+-SIM session is ended but the text shall sustain until the expiration of
+a short delay.
+
+
+27.22.4.1.4/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, sustained text, wait for user MMI to clear, successful
+
+Steps to execute
+-send a display text proactive command to the ME (wait for user to clear
+message)
+
+Expected Result
+-the following display text is displayed: "Toolkit Test 3"
+-SIM session is ended but the text shall sustain until a user MMI action.
+
+
+27.22.4.1.4/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, sustained text, wait for high priority event to clear,
+successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.1.5/1A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, display of basic icon, self-explanatory, successful
+
+Steps to execute
+-send a display text proactive command to the ME (BASIC-ICON, self-explana=
tory)
+-user clears the display text
+
+Expected Result
+-The BASIC-ICON is displayed
+-The BASIC-ICON is cleared by user
+
+
+27.22.4.1.5/1B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, display of basic icon, self-explanatory, requested icon could
+not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.1.5/2A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, display of colour icon, successful
+
+Steps to execute
+-send a display text proactive command to the ME (COLOUR-ICON)
+-user clears the display text
+
+Expected Result
+-The COLOUR-ICON is displayed
+-The COLOUR-ICON is cleared by user
+
+
+27.22.4.1.5/2B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, display of colour icon, requested icon could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.1.5/3A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, display of basic icon, not self explanatory, successful
+
+Steps to execute
+-send a display text proactive command to the ME (BASIC-ICON,
+not self-explanatory)
+-user clears the display text
+
+Expected Result
+-the following text is displayed: "Basic-Icon" and the BASIC-ICON is displ=
ayed
+-The display text is cleared by user
+
+
+27.22.4.1.5/3B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, display of basic icon, not self explanatory, requested icon
+could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.1.6/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DISPLAY TEXT, UCS2 coded
+
+Steps to execute
+-send a display text proactive command to the ME (Normal priority, UCS2 co=
ded)
+-user clears the message
+
+Expected Result
+-the following display text is displayed: "=D0=97=D0=94=D0=A0=D0=90=D0=92=
=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95" (Hello in Russian)
+-display text is cleared by user
+
+
+27.22.4.2.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, digits only for character, Unpacked 8 bit data for Text String,
+successful	=

+
+Steps to execute
+-send a get inkey proactive command to the ME (digits only, Unpacked 8 bit=
 data
+for Text String)
+-user enters "+"
+
+Expected Result
+-the following text is displayed: "Enter  "+""
+-command is performed successfully
+
+
+27.22.4.2.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, digits only for character set, SMS default Alphabet for Text
+String, successful
+
+Steps to execute
+-send a get inkey proactive command to the ME (digits only, SMS default
+Alphabet for Text String)
+-user enters "0"
+
+Expected Result
+-the following text is displayed: "Enter  "0""
+-command is performed successfully
+
+
+27.22.4.2.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, backward move
+
+Steps to execute
+-send a get inkey proactive command to the ME (digits only, backward move)
+-user goes back in SIM session
+
+Expected Result
+-the following display text is displayed: "<GO-BACKWARDS>"
+-SIM session goes back to previous menu
+
+
+27.22.4.2.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, abort
+
+Steps to execute
+-send a get inkey proactive command to the ME (session terminated by user)
+-user terminates the SIM session
+
+Expected Result
+-the following text is displayed: "<ABORT>"
+-SIM session is ended by user
+
+
+27.22.4.2.1/5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, SMS default alphabet for character set, Unpacked 8 bit data for
+Text String, successful
+
+Steps to execute
+-send a get inkey proactive command to the ME (characters from SMS default
+alphabet, Unpacked 8 bit data for Text String)
+-user enters "q"
+
+Expected Result
+-the following text is displayed: "Enter  "q""
+-command is performed successfully
+
+
+27.22.4.2.1/6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, Max length for the Text String, successful
+
+Steps to execute
+-send a get inkey proactive command to the ME (Max length for the Text Str=
ing)
+-user enters "x"
+
+Expected Result
+-the following text is displayed: "Enter "x". This command instructs
+the ME to display text, and to expect the user to enter a single character=
. Any
+response entered by the user shall be passed t"
+-command is performed successfully
+
+
+27.22.4.2.2/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, no response from the user
+
+Steps to execute
+-send a get inkey proactive command to the ME (digits only, no response fr=
om
+the user)
+-user does not send a response
+
+Expected Result
+-the following text is displayed: "<TIME OUT>"
+-"No response from user" is received within 5 s after the end of that defi=
ned
+period of time
+
+
+27.22.4.2.3/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, Text String coding in UCS2 Alphabet, successful
+
+Steps to execute
+-send a get inkey proactive command to the ME (digits only, UCS2 coded)
+-user enters "+"
+
+Expected Result
+-the following text is displayed: "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=
=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95" (Hello in Russian)
+-command is performed successfully
+
+
+27.22.4.2.3/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, max length for the Text String coding in UCS2 Alphabet, success=
ful
+
+Steps to execute
+-send a get inkey proactive command to the ME (digits only, max length for
+the Text String coding in UCS2 Alphabet)
+-user enters "+"
+
+Expected Result
+-the following text is displayed:
+"=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=
=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=
=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=
=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=
=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=
=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99"
+-command is performed successfully
+
+
+27.22.4.2.5/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, "Yes/No" Response for the input, successful
+
+Steps to execute
+-send a get inkey proactive command to the ME ("Yes/No" Response)
+-user enters "yes"
+-send a get inkey proactive command to the ME ("Yes/No" Response)
+-user enters "no"
+
+Expected Result
+-the following text is displayed: "Enter YES"
+-command is performed successfully
+-the following text is displayed: "Enter NO"
+-command is performed successfully
+
+
+27.22.4.2.6/1A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, Basic icon, self-explanatory, successful
+
+Steps to execute
+-send a get inkey proactive command to the ME (BASIC-ICON, self-explanator=
y)
+-user enters "+"
+
+Expected Result
+-The BASIC-ICON is displayed
+-command is performed successfully
+
+
+27.22.4.2.6/1B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, Basic icon, self-explanatory, requested icon could not be displ=
ayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.2.6/2A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, Basic icon, non self-explanatory, successful
+
+Steps to execute
+-send a get inkey proactive command to the ME (BASIC-ICON,
+non self-explanatory)
+-user enters "+"
+
+Expected Result
+-The BASIC-ICON is displayed with the text "<BASIC ICON>"
+-command is performed successfully
+
+
+27.22.4.2.6/2B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, Basic icon, non self-explanatory, requested icon could not be
+displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.2.6/3A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, Colour icon, self-explanatory, successful
+
+Steps to execute
+-send a get inkey proactive command to the ME (COLOUR-ICON, self-explanato=
ry)
+-user enters "+"
+
+Expected Result
+-The COLOUR-ICON is displayed
+-command is performed successfully
+
+
+27.22.4.2.6/3B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, Colour icon, self-explanatory, requested icon could not be
+displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.2.6/4A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, Colour icon, non self-explanatory, successful
+
+Steps to execute
+-send a get inkey proactive command to the ME (COLOUR-ICON,
+non self-explanatory)
+-user enters "+"
+
+Expected Result
+-The COLOUR-ICON is displayed with the text "<COLOUR ICON>"
+-command is performed successfully
+
+
+27.22.4.2.6/4B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INKEY, Colour icon, non self-explanatory, requested icon could not be
+displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.3.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, digits only, SMS default alphabet, ME to echo text, ME supporti=
ng 8
+bit data Message
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to echo text, packing not required)
+-user enters "12345"
+
+Expected Result
+-the following text is displayed: "Enter 12345"
+-command is performed successfully
+
+
+27.22.4.3.1/10
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, null length for the text string, successful
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to echo text, packing not required, null length for the text
+string)
+-user enters "12345"
+
+Expected Result
+-request for input is displayed without text
+-command is performed successfully
+
+
+27.22.4.3.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, digits only, SMS default alphabet, ME to echo text, packing SMS
+Point-to-point required by ME
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to echo text, packing SMS Point-to-point required by ME)
+-user enters "67*#+"
+
+Expected Result
+-the following text is displayed: "Enter 67*#+"
+-command is performed successfully
+
+
+27.22.4.3.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, character set, SMS Default Alphabet, ME to echo text, ME suppor=
ting
+8 bit data Message
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to echo text, ME supporting 8 bit data Message)
+-user enters "AbCdE"
+
+Expected Result
+-the following text is displayed: "Enter AbCdE"
+-command is performed successfully
+
+
+27.22.4.3.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, digits only, SMS default alphabet, ME to hide text, ME supporti=
ng 8
+bit data Message
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to hide text, ME supporting 8 bit data Message)
+-user enters "2345678"
+
+Expected Result
+-the following text is displayed: "Password 1<SEND>2345678"
+-user input are not displayed or digits are replaced by "*" then command is
+performed successfully
+
+
+27.22.4.3.1/6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, backwards move
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to echo text, packing not required, backwards move)
+-user goes back in SIM session
+
+Expected Result
+-the following text is displayed: "<GO-BACKWARDS>"
+-SIM session goes back to previous menu
+
+
+27.22.4.3.1/7
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, abort
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to echo text, packing not required, abort)
+-user terminates the SIM session
+
+Expected Result
+-the following text is displayed: "<ABORT>"
+-SIM session is ended by user
+
+
+27.22.4.3.1/8
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, digits only, SMS default alphabet, ME to echo text, ME supporti=
ng 8
+bit data Message
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to echo text, ME supporting 8 bit data Message)
+-user enters ""***1111111111###***2222222222###***3333333333###***44444444=
44###
+***5555555555###***6666666666###***7777777777###***8888888888###***9999999=
999
+###***0000000000###""
+
+Expected Result
+-the following text is displayed: "***1111111111###***2222222222###***3333=
33333
+3###***4444444444###***5555555555###***6666666666###***7777777777###***
+8888888888###***9999999999###***0000000000###"
+-command is performed successfully
+
+
+27.22.4.3.1/9
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, digits only, SMS default alphabet, ME to echo text, ME supporti=
ng 8
+bit data Message
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to echo text, ME supporting 8 bit data Message)
+-user clears the message
+
+Expected Result
+-the following text is displayed: "<SEND>"
+-command is performed successfully
+
+
+27.22.4.3.2/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, no response from the user
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to echo text, packing not required)
+-user does not send a respond
+
+Expected Result
+-the following text is displayed: "<TIME OUT>"
+-"No response from user" is received within 5 s after the end of that defi=
ned
+period of time
+
+
+27.22.4.3.3/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, text string coding in UCS2, successful
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to echo text, packing not required, text string coding in UCS=
2)
+-user enters "HELLO"
+
+Expected Result
+-the following text is displayed: "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=
=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95"
+-command is performed successfully
+
+
+27.22.4.3.3/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, max length for the text string coding in UCS2, successful
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to echo text, packing not required, max length for the text s=
tring
+coding in UCS2)
+-user enters "HELLO"
+
+Expected Result
+-the following text is displayed: "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=
=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=
=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=
=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92
+=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=
=A3=D0=99"
+-command is performed successfully
+
+
+27.22.4.3.5/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, default text for the input with max length, successful
+
+Steps to execute
+-send a get input proactive command to the ME (digits only, SMS default
+alphabet, ME to echo text, packing not required, default text for the input
+with max lengt)
+-user clears the message
+
+Expected Result
+-the following text is displayed: "Enter:" then "***1111111111###***222222=
2222
+###***3333333333###***4444444444###***5555555555###***6666666666###***
+7777777777###***8888888888###***9999999999###***0000000000###"
+-command is performed successfully
+
+
+27.22.4.3.6/1A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, Basic icon, self-explanatory, successful
+
+Steps to execute
+-send a get input proactive command to the ME (BASIC-ICON, self-explanator=
y)
+-user enters "+"
+
+Expected Result
+-The BASIC-ICON is displayed
+-command is performed successfully
+
+
+27.22.4.3.6/1B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, Basic icon, self-explanatory, requested icon could not be displ=
ayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.3.6/2A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, Basic icon, non self-explanatory, successful
+
+Steps to execute
+-send a get input proactive command to the ME (BASIC-ICON,
+non self-explanatory)
+-user enters "+"
+
+Expected Result
+-The BASIC-ICON is displayed with the text "<BASIC ICON>"
+-command is performed successfully
+
+
+27.22.4.3.6/2B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, Basic icon, non self-explanatory, requested icon could not be
+displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.3.6/3A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, Colour icon, self-explanatory, successful
+
+Steps to execute
+-send a get input proactive command to the ME (COLOUR-ICON,
+self-explanatory)
+-user enters "+"
+
+Expected Result
+-The COLOUR-ICON is displayed
+-command is performed successfully
+
+
+27.22.4.3.6/3B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, Colour icon, self-explanatory, requested icon could not be
+displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.3.6/4A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, Colour icon, non self-explanatory, successful
+
+Steps to execute
+-send a get input proactive command to the ME (COLOUR-ICON,
+non self-explanatory)
+-user enters "+"
+
+Expected Result
+-The COLOUR-ICON is displayed with the text "<COLOUR ICON>"
+-command is performed successfully
+
+
+27.22.4.3.6/4B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, Colour icon, non self-explanatory, requested icon could not be
+displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.3.7/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GET INPUT, digits only, ME to echo text, ME supporting 8 bit data Message,
+help information available
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.4.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MORE TIME
+
+Steps to execute
+-send a more time proactive command to the ME
+
+Expected Result
+-command is performed successfully
+
+
+27.22.4.5.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+PLAY TONE
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.6.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+POLL INTERVAL, Seconds
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.7.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+REFRESH, SIM Initialization
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.7.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+REFRESH, File Change Notification
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.7.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+REFRESH, SIM Initialization and File Change Notification
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.7.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+REFRESH, SIM Initialization and Full File Change Notification
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.7.1/5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+REFRESH, SIM Reset
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.7.1/6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+REFRESH, SIM Initialization after SMS-PP data download
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.7.2/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+REFRESH, SIM Initialization and File Change Notification
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.7.2/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+REFRESH, SIM Initialization and Full File Change Notification
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.7.2/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+REFRESH, SIM Reset
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.8.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP MENU, Large Menu with many items or with large items or with Large
+Alpha Identifier
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.8.2/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP MENU and MENU SELECTION, with Help Request, Replace and Remove a
+Toolkit Menu
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.8.3/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP MENU, next action indicator "Send SM", "Set Up Call", "Launch Brows=
er",
+"Provide Local Information", successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.8.4/1A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP MENU, BASIC ICON NOT SELF EXPLANATORY in ALPHA ID and ITEMS DATA
+OBJECTS, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.8.4/1B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP MENU, BASIC ICON NOT SELF EXPLANATORY in ALPHA ID and ITEMS DATA
+OBJECTS, requested icon could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.8.4/2A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP MENU, BASIC ICON SELF EXPLANATORY in ALPHA ID and ITEMS DATA OBJECT=
S,
+successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.8.4/2B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP MENU, BASIC ICON SELF EXPLANATORY in ALPHA ID and ITEMS DATA OBJECT=
S,
+requested icon could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.8.5/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP MENU, SOFT KEY PREFERRED, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, mandatory features, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, large menu, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, call options, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, backward move by user, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.1/5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, "Y", successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.1/6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, Large menu, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.2/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, next action indicator, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.3/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, default item, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.5/1A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, BASIC ICON NOT SELF EXPLANATORY, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.5/1B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, BASIC ICON NOT SELF EXPLANATORY, requested icon could not be
+displayed	=

+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.5/2A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, BASIC ICON SELF EXPLANATORY, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.5/2B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, BASIC ICON SELF EXPLANATORY, requested icon could not be
+displayed	=

+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.6/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, PRESENTATION AS A CHOICE OF NAVIGATION OPTIONS, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.6/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, PRESENTATION AS A CHOICE OF DATA VALUES, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.7/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, SELECTING USING SOFT KEYS PREFERRED, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.9.8/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SELECT ITEM, no response from user
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.10.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SHORT MESSAGE, packing not required, 8-bit data, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.10.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SHORT MESSAGE, packing not required, SMS default alphabet, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.10.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SHORT MESSAGE, packing required, 8 bit data, message of 160 characters
+user databytes, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.10.1/5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SHORT MESSAGE, packing not required, SMS default alphabet, message of=
 160
+bytes characters user data, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.10.1/6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SHORT MESSAGE, alpha identifier 160 bytes long, SMS default alphabet,
+successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.10.1/7
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SHORT MESSAGE, alpha identifier length '00', packing not required, 8-=
bit
+data, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.10.1/8
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SHORT MESSAGE, packing not required, 8-bit data, no alpha identifier,
+successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.10.2/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SHORT MESSAGE, packing not required, UCS2 (16-bit data)
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.10.3/1A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SHORT MESSAGE, basic icon self-explanatory, packing not required, 8-b=
it
+data, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.10.3/1B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SHORT MESSAGE, basic icon self-explanatory, packing not required, 8-b=
it
+data, requested icon could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.10.3/2A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SHORT MESSAGE, basic icon non-self-explanatory, packing not required,
+8-bit data, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.10.3/2B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SHORT MESSAGE, basic icon non-self-explanatory, packing not required,
+8-bit data, requested icon could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.1/1A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.1/1B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, Return Error
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers Reject
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.1/4A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful, SS request s=
ize
+limit
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.1/4B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful, SS request s=
ize
+limit
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.1/5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, interrogate CLIR status, successful, alpha identifier limits
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.1/6A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful, null data al=
pha
+identifier
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.1/6B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful, null data al=
pha
+identifier
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.2/1A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful, basic icon s=
elf
+explanatory, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.2/1B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful, basic icon s=
elf
+explanatory, requested icon could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.2/2A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful, colour icon =
self
+explanatory, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.2/2B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful, colour icon =
self
+explanatory, requested icon could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.2/3A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful, basic icon n=
on
+self-explanatory, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.2/3B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful, basic icon n=
on
+self-explanatory
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.2/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful, basic icon n=
on
+self-explanatory, no alpha identifier presented
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.11.3/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND SS, call forward unconditional, all bearers, successful, UCS2 text
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 7-bit data, successful
+
+Steps to execute
+-send an USSD proactive command to ME (7-bit data)
+
+Expected Result
+-the USSD string "ABCDEFGHIJKLMNOPQRSTUVWXYZ-abcdefghijklmnopqrstuvwxyz-12=
34567
+890" is received from SS
+
+
+27.22.4.12.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 8-bit data, successful	=

+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, UCS2 data, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 7-bit data, unsuccessful (Return Error)
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.1/5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 7-bit data, unsuccessful (Reject)
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.1/6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 256 octets, 7-bit data, successful, long alpha identifier
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.1/7
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 7-bit data, successful, no alpha identifier
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.1/8
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 7-bit data, successful, null length alpha identifier
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.2/1A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 7-bit data, successful, basic icon self explanatory, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.2/1B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 7-bit data, successful, basic icon self explanatory, requested =
icon
+could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.2/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 7-bit data, successful, colour icon self explanatory
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.2/3A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 7-bit data, successful, basic icon non self-explanatory, succes=
sful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.2/3B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 7-bit data, successful, basic icon non self-explanatory, reques=
ted
+icon could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.2/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 7-bit data, basic icon non self-explanatory, no alpha identifier
+presented
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.12.3/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND USSD, 7-bit data, successful, UCS2 text
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, call confirmed by the user and connected
+
+Steps to execute
+-send a set up call proactive command to ME (call confirmed by the user and
+connected)
+-user confirms to set up a call
+-user ends the call after 10s
+
+Expected Result
+-set up a call to "+012340123456" is asked to user for confirmation
+-the command is performed successfully
+-the ME returns in idle mode
+
+
+27.22.4.13.1/10
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, 256 octets length, long first alpha identifier
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.1/11B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, Called party subaddress, ME not supporting the called party
+subaddress
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, call rejected by the user
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, putting all other calls on hold, ME busy
+
+Steps to execute
+-./dial-number 123456789
+-accept the call
+-send a set up call proactive command to the ME (putting all other calls on
+hold)
+-user confirms to set up a call
+-user ends the call after 10s
+
+Expected Result
+-incoming call is received =

+-call is accepted
+-second call is asked to the user for confirmation
+-first call is put on hold, the command is performed successfully
+-second call is released, first one is still on hold
+
+27.22.4.13.1/5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, disconnecting all other calls, ME busy
+
+Steps to execute
+-./dial-number 123456789
+-accept the call
+-send a set up call proactive command to the ME (disconnecting all other c=
alls
+on hold)
+-user confirms to set up a call
+-user ends the call after 10s
+
+Expected Result
+-incoming call is received =

+-call is accepted
+-second call is asked to the user for confirmation
+-first call is disconnected, the command is performed successfully
+-second call is released
+
+
+27.22.4.13.1/6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, only if not currently busy on another call, ME busy
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.1/7
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, putting all other calls on hold, call hold is not allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.1/8
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, Capability configuration
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.1/9
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, max dialling number string, no alpha identifier
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.2/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, two alpha identifiers
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.3/1A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, display of basic icon during confirmation phase, not
+self-explanatory, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.3/1B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, display of basic icon during confirmation phase, not
+self-explanatory, requested icon could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.3/2A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, display of basic icon during confirmation phase,
+self-explanatory, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.3/2B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, display of basic icon during confirmation phase,
+self-explanatory, requested icon could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.3/3A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, display of colour icon during confirmation phase, not
+self-explanatory, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.3/3B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, display of colour icon during confirmation phase, not
+self-explanatory, requested icon could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.3/4A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, display of self explanatory basic icon during set up call,
+successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.13.3/4B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP CALL, display of self explanatory basic icon during set up call,
+requested icon could not be displayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.15.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+PROVIDE LOCAL INFORMATION, Local Info (MCC, MNC, LAC & Cell ID)
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.15.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+PROVIDE LOCAL INFORMATION, IMEI of the ME
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.15.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+PROVIDE LOCAL INFORMATION, Network Measurement Results (NMR)
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.15.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+PROVIDE LOCAL INFORMATION, Date, Time, Time Zone
+
+Steps to execute
+-send a provide local information proactive command to the ME (Date, Time,
+Time Zone)
+
+Expected Result
+-the command is performed successfully
+
+
+27.22.4.15.1/5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+PROVIDE LOCAL INFORMATION, Language setting
+
+Steps to execute
+-send a provide local information proactive command to the ME (Language
+setting)
+
+Expected Result
+-the command is performed successfully
+
+
+27.22.4.15.1/6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+PROVIDE LOCAL INFORMATION, Timing advance
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.16.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP EVENT LIST, Set Up Call Connect Event
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.16.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP EVENT LIST, Replace Event
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.16.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP EVENT LIST, Remove Event
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.16.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP EVENT LIST, Remove Event on ME Power Cycle
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.21.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+TIMER MANAGEMENT, start timer 1 several times, get the current value of the
+timer and deactivate the timer successfully
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.21.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+TIMER MANAGEMENT, start timer 8 several times, get the current value of the
+timer and deactivate the timer successfully
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.21.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+TIMER MANAGEMENT, try to get the current value of a timer which is not
+started: action in contradiction with the current timer state
+
+Steps to execute
+-send a timer management proactive command (try to get the current value of
+a timer which is not started)
+
+Expected Result
+-action is in contradiction with the current timer state
+
+
+27.22.4.21.1/5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+TIMER MANAGEMENT, try to deactivate a timer which is not started: action in
+contradiction with the current timer state
+
+Steps to execute
+-send a timer management proactive command (try to deactivate a timer whic=
h is
+not started)
+
+Expected Result
+-action is in contradiction with the current timer state
+
+
+27.22.4.21.1/6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+TIMER MANAGEMENT, start 8 timers successfully
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, replace idle mode text
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, remove idle mode text
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, competing information on ME display
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.1/5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, ME power cycled
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.1/6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, REFRESH with SIM Initialization
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.1/7
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, large text string
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.2/1A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, Icon is self-explanatory, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.2/1B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, Icon is self-explanatory, requested icon could not =
be
+displayed	=

+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.2/2A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, Icon is not self-explanatory, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.2/2B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, Icon is not self-explanatory, requested icon could =
not
+be displayed	=

+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.2/3A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, Icon is self-explanatory, colour icon, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.2/3B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, Icon is self-explanatory, colour icon, requested ic=
on
+could not be displayed	=

+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.2/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, Icon is not self-explanatory, empty text string
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.22.3/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SET UP IDLE MODE TEXT, UCS2 alphabet text
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.24.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND DTMF, normal
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.24.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND DTMF, containing alpha identifier
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.24.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND DTMF, containing alpha identifier with null data object
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.24.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND DTMF, mobile is not in a speech call
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.24.2/1A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND DTMF, BASIC ICON self explanatory, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.24.2/1B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND DTMF, BASIC ICON self explanatory, requested icon could not be displa=
yed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.24.2/2A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND DTMF, COLOUR-ICON self explanatory, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.24.2/2B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND DTMF, COLOUR-ICON self explanatory, requested icon could not be displ=
ayed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.24.2/3A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND DTMF, Alpha identifier & BASIC-ICON, not self-explanatory, successful
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.24.2/3B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND DTMF, Alpha identifier & BASIC-ICON, not self-explanatory, requested =
icon
+could not be displayed	=

+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.4.24.3/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SEND DTMF, successful, UCS2 text
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.5.1.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SMS-PP Data Download, General Data Coding, GET RESPONSE, Acknowledgement
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.5.1.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SMS-PP Data Download, General Data Coding, FETCH, MORE TIME
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.5.1.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SMS-PP Data Download, General Data Coding
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.5.1.1/6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SMS-PP Data Download, with Data Coding / Message Class
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.5.2.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SMS-CB (Data Download), ENVELOPE(SMS-CB DOWNLOAD), ME does not display mes=
sage
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.5.2.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SMS-CB (DATA DOWNLOAD), ENVELOPE(SMS-CB DATA DOWNLOAD), FETCH, MORE TIME, =
ME
+does not display message
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.5.2.1/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SMS-CB (DATA DOWNLOAD), ME displays message
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call attempt by user, the SIM respondswith '90
+00'
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/10
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call attempt by user to an emergency call
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/11
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call through call register, the SIM responds =
with
+'90 00'
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/12
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call through call register, allowed without
+modification
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/13
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call through call register, not allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/14
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call through call register, allowed with
+modifications
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call attempt by user, allowed without
+modification
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/3A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call attempt resulting from a set up call
+proactive command, allowed without modification
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/3B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call attempt resulting from a set up call
+proactive command, allowed without modification
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call attempt by user, not allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/5A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call attempt resulting from a set up call
+proactive command, not allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/5B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call attempt resulting from a set up call
+proactive command, not allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call attempt by user, allowed with modificati=
ons
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/7A
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM, set up call attempt resulting from a set up call
+proactive command, allowed with modifications
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/7B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM, set up call attempt resulting from a set up call
+proactive command, allowed with modifications
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/8
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call attempt by user, allowed with modificati=
ons:
+emergency call
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.1/9
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up call attempt by user, allowed with modificati=
ons:
+number in EFECC
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.2/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , send SS, the SIM responds with '90 00'
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.2/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , send SS, allowed without modifications
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.2/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , send SS, not allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.2/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , send SS, allowed with modifications
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.3/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up a call not in EFFDN
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.3/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up a call in EFFDN , the SIM responds with '90 0=
0'
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.3/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up a call in EFFDN, Allowed without modifications
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.3/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up a call in EFFDN , Not Allowed
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.3/5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up a call in EFFDN , Allowed with modifications
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.4/1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up a call in EFBDN
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.4/2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up a call not in EFBDN , Allowed without
+modifications	=

+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.4/3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , set up a call not in EFBDN , Allowed with modificati=
ons
+
+Steps to execute
+-
+
+Expected Result
+-
+
+
+27.22.6.4/4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CALL CONTROL BY SIM , FDN and BDN enabled, set up a call in EFFDN, Allowed
+with modifications
+
+Steps to execute
+-
+
+Expected Result
+-
+
-- =

1.7.5.4


--===============1610990511461622059==--

