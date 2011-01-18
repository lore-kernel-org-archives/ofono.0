Content-Type: multipart/mixed; boundary="===============4302483100825490707=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: Re: Ofono CF states not always correct
Date: Tue, 18 Jan 2011 14:21:25 +0200
Message-ID: <1295353285.23534.227.camel@poutijar-desktop>
In-Reply-To: <4D3072F6.60403@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4302483100825490707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 2011-01-14 at 17:59 +0200, Denis Kenzior wrote:
> Hi Jarko,
> =

> Both are active and the modem should be reporting both.  At least that
> is how I understood the specifications.
> =

Well that is a bit debatable. As 27.007 states:
command:
+CCFC=3D<reason>,<mode>[,<number>[,<type>[,<class>[,<subaddr>[,<satype>[,<t=
ime>]]]]]]

<reason>: integer type
0 unconditional
1 mobile busy
2 no reply
3 not reachable
4 all call forwarding (refer 3GPP TS 22.030 [19])
5 all conditional call forwarding (refer 3GPP TS 22.030 [19])

<mode>: integer type
0 disable
1 enable
2 query status
3 registration
4 erasure

response when<mode>=3D2 and command successfull:
+CCFC:<status>,<class1>[,<number>,<type>[,<subaddr>,<satype>[,<time>]]][<CR=
><LF>+CCFC: <status>,<class2>[,<number>,<type>[,<subaddr>,<satype>[,<time>]=
]][...]]

<status>: integer type
0 not active
1 active

So actually they aren't both "active" at same time as the logs show but
personally I don't really care as long as the results are consistent
regardless which API you use which is not the case at the moment as
querying through org.ofono.CallForwarding can give you different result
than using org.ofono.SupplementaryServices.

> A bit, but having the AT command logs would help greatly.

Well hopefully these will help. I have numbered each step and copied
corresponding logs after it. list-modems doesn't cause AT queries to
modem(except on a very first time which I have already done) so I have
copied what it prints regarding CF. It's a bit long though so sorry
about that.

#1: ./list-modems
    [ org.ofono.CallForwarding ]
        ForwardingFlagOnSim =3D 0
        VoiceNoReplyTimeout =3D 20
        VoiceNotReachable =3D =

        VoiceBusy =3D =

        VoiceNoReply =3D =

        VoiceUnconditional =3D =


#2: ./test-ussd '**61*+358401234567*11#'
ofonod[30925]: Default: > AT+CCFC=3D2,3,"358401234567",145,1,,,20\r
ofonod[30925]: Default: < \r\nOK\r\n
ofonod[30925]: Default: > AT+CCFC=3D2,2\r
ofonod[30925]: Default: < \r\n+CCFC: 1,1,"0401234567",129,"",,20\r\n\r
\nOK\r\n

#3: ./list-modems
    [ org.ofono.CallForwarding ]
        ForwardingFlagOnSim =3D 0
        VoiceNoReplyTimeout =3D 20
        VoiceNotReachable =3D =

        VoiceBusy =3D =

        VoiceNoReply =3D 0401234567
        VoiceUnconditional =3D =


#4: ./test-ussd '**21*+358401234567*11#'
ofonod[30925]: Default: > AT+CCFC=3D0,3,"358401234567",145,1\r
ofonod[30925]: Default: < \r\nOK\r\n
ofonod[30925]: Default: > AT+CCFC=3D0,2\r
ofonod[30925]: Default: < \r\n+CCFC: 1,1,"0401234567",129\r\n\r\nOK\r\n

#5: ./list-modems
    [ org.ofono.CallForwarding ]
        ForwardingFlagOnSim =3D 1
        VoiceNoReplyTimeout =3D 20
        VoiceNotReachable =3D =

        VoiceBusy =3D =

        VoiceNoReply =3D 0401234567
        VoiceUnconditional =3D 0401234567

#6: ./test-ussd '*#002#'
ofonod[30925]: Default: > AT+CCFC=3D0,2\r
ofonod[30925]: Default: < \r\n+CCFC: 1,1,"0401234567",129\r\n\r\nOK\r\n
ofonod[30925]: Default: > AT+CCFC=3D1,2\r
ofonod[30925]: Default: < \r\n+CCFC: 0,1\r\n+CCFC: 0,4\r\n+CCFC: 0,16\r
\n
ofonod[30925]: Default: < +CCFC: 0,32\r\n+CCFC: 0,64\r\n
ofonod[30925]: Default: < +CCFC: 0,128\r\n\r\nOK\r\n
ofonod[30925]: Default: > AT+CCFC=3D2,2\r
ofonod[30925]: Default: < \r\n+CCFC: 0,1\r\n+CCFC: 0,4\r\n
ofonod[30925]: Default: < +CCFC: 0,16\r\n+CCFC: 0,32\r\n
ofonod[30925]: Default: < +CCFC: 0,64\r\n+CCFC: 0,128\r\n
ofonod[30925]: Default: < \r\nOK\r\n
ofonod[30925]: Default: > AT+CCFC=3D3,2\r
ofonod[30925]: Default: < \r\n+CCFC: 0,1\r\n+CCFC: 0,4\r\n
ofonod[30925]: Default: < +CCFC: 0,16\r\n+CCFC: 0,32\r\n+CCFC: 0,64\r\n
ofonod[30925]: Default: < +CCFC: 0,128\r\n\r\nOK\r\n

#7: ./list-modems
    [ org.ofono.CallForwarding ]
        ForwardingFlagOnSim =3D 1
        VoiceNoReplyTimeout =3D 20
        VoiceNotReachable =3D =

        VoiceBusy =3D =

        VoiceNoReply =3D =

        VoiceUnconditional =3D 0401234567

#8: ./test-ussd '##21#'
ofonod[30925]: Default: > AT+CCFC=3D0,4\r
ofonod[30925]: Default: < \r\nOK\r\n
ofonod[30925]: Default: > AT+CCFC=3D0,2\r
ofonod[30925]: Default: < \r\n+CCFC: 0,1\r\n
ofonod[30925]: Default: < +CCFC: 0,4\r\n+CCFC: 0,16\r\n+CCFC: 0,32\r\n
ofonod[30925]: Default: < +CCFC: 0,64\r\n+CCFC: 0,128\r\n
ofonod[30925]: Default: < \r\nOK\r\n

#9: ./list-modems
    [ org.ofono.CallForwarding ]
        ForwardingFlagOnSim =3D 0
        VoiceNoReplyTimeout =3D 20
        VoiceNotReachable =3D =

        VoiceBusy =3D =

        VoiceNoReply =3D =

        VoiceUnconditional =3D =


#10: ./test-ussd '*#002#'
ofonod[30925]: Default: > AT+CCFC=3D0,2\r
ofonod[30925]: Default: < \r\n+CCFC: 0,1\r\n+CCFC: 0,4\r\n+CCFC: 0,16\r
\n
ofonod[30925]: Default: < +CCFC: 0,32\r\n+CCFC: 0,64\r\n
ofonod[30925]: Default: < +CCFC: 0,128\r\n\r\nOK\r\n
ofonod[30925]: Default: > AT+CCFC=3D1,2\r
ofonod[30925]: Default: < \r\n+CCFC: 0,1\r\n+CCFC: 0,4\r\n
ofonod[30925]: Default: < +CCFC: 0,16\r\n+CCFC: 0,32\r\n+CCFC: 0,64\r\n
ofonod[30925]: Default: < +CCFC: 0,128\r\n\r\nOK\r\n
ofonod[30925]: Default: > AT+CCFC=3D2,2\r
ofonod[30925]: Default: < \r\n+CCFC: 1,1,"0401234567",129,"",,20\r\n\r
\nOK\r\n
ofonod[30925]: Default: > AT+CCFC=3D3,2\r
ofonod[30925]: Default: < \r\n+CCFC: 0,1\r\n
ofonod[30925]: Default: < +CCFC: 0,4\r\n+CCFC: 0,16\r\n
ofonod[30925]: Default: < +CCFC: 0,32\r\n+CCFC: 0,64\r\n
ofonod[30925]: Default: < +CCFC: 0,128\r\n\r\nOK\r\n

#11: ./list-modems
    [ org.ofono.CallForwarding ]
        ForwardingFlagOnSim =3D 0
        VoiceNoReplyTimeout =3D 20
        VoiceNotReachable =3D =

        VoiceBusy =3D =

        VoiceNoReply =3D 0401234567
        VoiceUnconditional =3D =


So as can be seen the result changes between #5 and #7 although nothing
has been changed. What's more concerning is that@#9 ofono claims that
no CF is active but as can be seen in #11 actually VoiceNoReply no
longer is "quiescent" but "active".

-Jarko-


--===============4302483100825490707==--

