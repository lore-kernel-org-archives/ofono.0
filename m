Content-Type: multipart/mixed; boundary="===============2486202852282160450=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC PATCH 1/1] atmodem/lte: Gemalto vendor specific extension
Date: Thu, 18 Oct 2018 09:57:52 +0200
Message-ID: <CAKSBH7HGiYRzGRuk9kPmK7Bu3Ljw32Zgp7cTPzbRaGCcZ4W=bA@mail.gmail.com>
In-Reply-To: <860a87d3-266a-2e4d-1a3c-baa0c429cb81@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2486202852282160450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>
> I thought the default APN was cid=3D0.
>

In the standard yes.
I see in ofono code that the xmm7xxx modem uses the LTE atom as-is, so
maybe there is at least one modem that implements it.

Gemalto uses normally cid=3D1 and for some operators cid=3D3.
uBlox uses cid=3D1 and cid=3D4, depending on the models.
For other vendors, I don't know.

I have taken the rest of the suggestions in your message, and I am
going to resubmit shortly.

It would be good if someone could test on these xmm7xxx modems the
atmodem/lte atom, but I understand the lte attach authentication is
not a feature that everyone can access.
I am going to submit it anyway, and it can be amended in the future
when someone can test it.

> Regards,
> -Denis

Regards,
Giacinto

--===============2486202852282160450==--

