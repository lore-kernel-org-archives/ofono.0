Content-Type: multipart/mixed; boundary="===============6957742658710472463=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Cinterion EHS6 support
Date: Wed, 29 Apr 2015 13:17:52 -0500
Message-ID: <55412050.7080504@gmail.com>
In-Reply-To: <55410AAC.6090609@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6957742658710472463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 04/29/2015 11:45 AM, Alex J Lennon wrote:
> Hi,
>
> I've created a patch which adds support for the Cinterion EHS6 to Ofono.
>
> This is based on the TC65 source code with some changes to address an
> issue with +CIND handling
>

Most likely TC65 has this issue as well.  Are there any other changes ?

> The patch is currently in a GitHub fork here
>
> https://github.com/DynamicDevices/ofono/commit/06c374b94bef2b3b23c9531c22=
977976ab7f6e99.patch
>
> This enables me to configure an "ehs6" rule in udev and bring up a GPRS
> connection successfully with Connman.
>
> Would it be possible to contribute this to Ofono? If so could somebody
> let me know what, if anything, needs to be done to the patch?
>

Generally, just send patches to the mailing list using git send-email. =

They will undergo the review process and will be applied to the upstream =

tree when/if they're ready.

The general submission guidelines are described in git. =

toplevel/HACKING, 'Submitting Patches' section.

Regards,
-Denis


--===============6957742658710472463==--

