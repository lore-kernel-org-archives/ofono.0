Content-Type: multipart/mixed; boundary="===============9094782752660544561=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/1] gisi: Updated subscriptions and pipe handling to
 accomodate additional isimodem versions
Date: Mon, 07 Feb 2011 12:01:03 +0200
Message-ID: <AANLkTi=dEMKzXy9F8oG19AkevUaAZMG9pJEkpip9KZD1@mail.gmail.com>
In-Reply-To: <AANLkTinWrKLgWUTgcTPEKObc8bp2qBrmD=AaaoPgOqd5@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9094782752660544561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2011/2/4 Aki Niemi <aki@protocolpolice.com>:
> This is problematic, since there is no version query by default for
> the PN_COMMGR because creating the GIsiModem is not async. Also, even
> the N900 modem supports both of these INDs, but the
> PNS_SUBSCRIBED_RESOURCES_EXTEND_IND is blocked by a modem side
> firewall.
>
> So I think we need something different here, like flags that the
> plugin can set to control which IND type gets used.

I just pushed a new API to set flags on a modem instance, and also
refactored the indication subscription logic based on this patch.

Please check that it works like you want it to.

Cheers,
Aki

--===============9094782752660544561==--

