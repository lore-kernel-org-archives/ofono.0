Content-Type: multipart/mixed; boundary="===============8072667238993992070=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: Restore multiparty call after reconnection
Date: Wed, 08 Oct 2014 10:17:37 -0500
Message-ID: <54355591.8090604@gmail.com>
In-Reply-To: <1412762028-17784-1-git-send-email-sergio.checa@oss.bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8072667238993992070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergio,

On 10/08/2014 04:53 AM, Sergio Checa Blanco wrote:
> From: Sergio Checa Blanco <sergio.checa@bmw-carit.de>
>
> When the HFP profile is disconnected while a multiparty call is
> ongoing, and it is reconnected again, oFono requests the list of
> current calls to the device with AT+CLCC. In the case of a multiparty
> call, the response to CLCC is being taken as multiple simple calls.
>
> The attribute mpty parsed in function at_util_parse_clcc is never
> used nor stored, so there is no way to recompose the information
> about multi-party calls after a reconnection.

Last I checked it does.  Is ofono_voicecall_mpty_hint() not doing what =

you need?

Regards,
-Denis

--===============8072667238993992070==--

