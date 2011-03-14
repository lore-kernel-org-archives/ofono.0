Content-Type: multipart/mixed; boundary="===============5953680006132696301=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Setting PDP mode
Date: Mon, 14 Mar 2011 09:21:55 -0500
Message-ID: <4D7E2483.4010006@gmail.com>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC2D0C3D@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5953680006132696301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 03/14/2011 05:13 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi Denis,
> =

>> The protocol selection (IP, IPv6 or dual stack IPv4 & IPv6 =

>> combined) is
>> currently work in progress, but we support IP contexts already. =

> =

> If by "work in progress" you're referring to my IPv6 patches, the progres=
s is pretty much stalled due to lack of response from you or Marcel for a c=
ouple of months now. Are you planning to review and/or push the patches or =
not? The next time I will send a patch, it will be to remove the work item =
from the TODO list due to lack of interest from maintainers.
>

I would not describe it as a lack of interest.  There were simply higher
priority items and I wanted to discuss this with Samuel first anyway.  I
have reworked your IPv6 patches and the API 'slightly' and just now
waiting on Marcel to cut a new release to push them.

>> oFono does not allow you to select the actual protocol used to talk to
>> the modem (e.g. PPP, high-speed, or some vendor specific) for gprs
>> contexts.  In fact it does not even care itself.  It is up to =

>> the modem
>> driver to figure out the best protocol for that particular modem.
> =

> Just FYI, PPP is a valid PDP context type, where the PPP protocol termina=
tes on the network side instead of in the modem. AFAIK, this configuration =
is not widely supported by cellular operators, though.
> =


Fair enough, that makes sense now that you mention it.

Regards,
-Denis

--===============5953680006132696301==--

