Content-Type: multipart/mixed; boundary="===============8687075228516470063=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH] hfp_hf_bluez5: Remove unneeded modem hash lookup
Date: Fri, 01 Feb 2013 11:03:49 -0300
Message-ID: <CAKT1EBdHmx8CqThVsfAwKzbg0YWNPp9pOuPT61ZR3OcLbezmwg@mail.gmail.com>
In-Reply-To: <1359725070-11626-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8687075228516470063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis:

On Fri, Feb 1, 2013 at 10:24 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Modem object is created when the Device Proxy is added, and it is
> paired. Another path is when the Device "Paired" property changes
> to True.

Ignore this patch. This verification is needed: Property Changed
callback for "Paired" is *always* called after Proxy Added.

Regards,
Claudio

--===============8687075228516470063==--

