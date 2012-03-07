Content-Type: multipart/mixed; boundary="===============5956007263625337706=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.homelinux.net>
Subject: Re: [Gta04-owner] Polling CLCC error handling on Option modem (GTA04)
Date: Wed, 07 Mar 2012 19:06:23 +0000
Message-ID: <87fwdk8c40.fsf@neil-laptop.ossau.uklinux.net>
In-Reply-To: <20120307104746.GA1221@tiny>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5956007263625337706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthias Apitz <guru@unixarea.de> writes:

>> ofonod[1188]: App: < \r\n+CLCC: 1,1,4,0,0,"+420608828973",145\r\n\r\nOK\=
r\n
>> ofonod[1188]: App: > AT+CLCC\r
>> ofonod[1188]: App: < \r\n+CME ERROR: 100\r\n
>> ofonod[1188]: We are polling CLCC and received an error, retrying...
>> ofonod[1188]: App: > AT+CLCC\r
>> ofonod[1188]: App: < \r\nOK\r\n
>> ofonod[1188]: src/voicecall.c:ofono_voicecall_disconnected() Got disconn=
ection =

>> event for id: 1, reason: 2
>
> I'm wondering if this ofonod log has no timestamps in the log lines? Or
> is this something to be configured?

oFono does its logging by calling syslog, so maybe the absence of
timestamps is to do with how syslog is configured on Radek's phone.

      Neil

--===============5956007263625337706==--

