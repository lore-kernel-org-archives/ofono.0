Content-Type: multipart/mixed; boundary="===============8953904901447183887=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: [PATCH 1/2] cinterion: Add cinterion vendor support
Date: Tue, 12 May 2015 19:27:37 +0200
Message-ID: <55523809.40209@dynamicdevices.co.uk>
In-Reply-To: <55438774.9010904@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8953904901447183887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 01/05/2015 16:02, Denis Kenzior wrote:
> Hi Alex,
>
> This part seems to be completely unnecessary?  At least by my reading
> of the code flow, at_cmer_set_cb is never called in the case of
> OFONO_VENDOR_CINTERION.
>
> This is not our coding style.  Please refer to doc/coding-style.txt
> and the Linux Kernel coding style document here:
> https://www.kernel.org/doc/Documentation/CodingStyle.

I've removed the check to ensure that the callback is not re-registered
accidentally and reformatted the patch-set, hopefully more in line with
your suggestions as to flow...

Thanks for the link to the ofono preferred coding style. I will make
time in the near future to take a look at this.

Best Regards,

Alex


--===============8953904901447183887==--

