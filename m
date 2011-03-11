Content-Type: multipart/mixed; boundary="===============7215770803323606466=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/5] Voice call SS notifications (4th version)
Date: Fri, 11 Mar 2011 13:52:04 -0600
Message-ID: <4D7A7D64.3040203@gmail.com>
In-Reply-To: <cover.1299258404.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7215770803323606466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

On 03/04/2011 11:12 AM, Andras Domokos wrote:
> Implementation proposal for handling some of the voice call
> related Supplementary Services (SS) notifications.
> =

> Implementation details:
> - removed SSN atom and all the dependencies
> - (re)implemented voice call SS notification handling framework
> - added voice call SS notification handling to AT modem driver
>   (+CSSU and +CSSI notifications) =

> - added voice call SS notification handling to ISI modem driver
> =

> Andras Domokos (5):
>   ssn: remove SSN atom completely
>   voicecall: add SSN function declarations
>   voicecall: implement SSN handling functions
>   atmodem: implement SSN handling
>   isimodem: implement SSN handling

I pushed all of these patches upstream, thanks.

Regards,
-Denis

--===============7215770803323606466==--

