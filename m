Content-Type: multipart/mixed; boundary="===============4450560684909079177=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/5] qmimodem: detect utf-8 string as operator name
Date: Thu, 23 Mar 2017 10:33:10 -0500
Message-ID: <3e4a3d38-5c66-7750-b292-f26233c55c73@gmail.com>
In-Reply-To: <1490206493-17454-4-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4450560684909079177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/22/2017 01:14 PM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> Telit QMI modems can return non-utf-8 characters in plmn-desc.
> Observed with LE910-SVG and Verizon. When that happens, libdbus
> will abort ofono.
> If non-utf-8 characters are detected, use mccmnc string.
> ---
>  drivers/qmimodem/network-registration.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============4450560684909079177==--

