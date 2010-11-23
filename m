Content-Type: multipart/mixed; boundary="===============3872196942969489250=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] Long dial string support (2nd)
Date: Tue, 23 Nov 2010 11:41:40 -0600
Message-ID: <4CEBFCD4.80204@gmail.com>
In-Reply-To: <cover.1290436058.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3872196942969489250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/22/2010 10:36 AM, Andras Domokos wrote:
> Dial strings can now be as long as 120 digits (not counting '+'). This fe=
ature
> is going to be needed by the FDN feature.
> =

> An FDN may consist of a phone number plus a DTMF string. In order to have=
 the
> call succeed when FDN is enabled, both parts need to be provided when mak=
ing a
> call, as a single dial string.

So as mentioned previously, oFono does not support FDN.  So why are we
doing this again?

> =

> For AT modems the long dial string can be and has to be passed as is to t=
he

Most AT modems have serious limitations on how many characters are
supported in the dial string.  Not to mention that the pause character
doesn't really always work.

I can understand supporting long dialing numbers, but supporting dial
strings is something else entirely...

Regards,
-Denis

--===============3872196942969489250==--

