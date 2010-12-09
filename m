Content-Type: multipart/mixed; boundary="===============1551841017280138354=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] Attach GPRS on demand
Date: Thu, 09 Dec 2010 02:02:18 -0600
Message-ID: <4D008D0A.3090904@gmail.com>
In-Reply-To: <1291306582-19024-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1551841017280138354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 12/02/2010 10:16 AM, Mika Liljeberg wrote:
> Hi All,
> =

> Currently, if GPRS service is detached for whatever reason, the only way
> to get PS services back is to set the Powered property to FALSE and back
> to TRUE.
> =

> With these patches, GPRS context activation will cause oFono to
> automatically attempt GPRS attach if the modem is presently detached.
> =


Before I look at these patches: Have you considered fixing the attach
behavior instead?  It seems like the approach you're proposing is
essentially hitting oFono over the head because it isn't doing what you
want...

Regards,
-Denis

--===============1551841017280138354==--

