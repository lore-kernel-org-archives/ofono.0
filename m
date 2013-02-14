Content-Type: multipart/mixed; boundary="===============8811639735738413461=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH] hfp_hf_bluez5: Remove unneeded modem hash lookup
Date: Thu, 14 Feb 2013 09:33:29 -0300
Message-ID: <CAKT1EBerPiNjSvX+5mvcxetTyzJ9n2uPDXLLBitPedgyOw8vPw@mail.gmail.com>
In-Reply-To: <CAKT1EBdHmx8CqThVsfAwKzbg0YWNPp9pOuPT61ZR3OcLbezmwg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8811639735738413461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis:

On Fri, Feb 1, 2013 at 11:03 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi Denis:
>
> On Fri, Feb 1, 2013 at 10:24 AM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> Modem object is created when the Device Proxy is added, and it is
>> paired. Another path is when the Device "Paired" property changes
>> to True.
>
> Ignore this patch. This verification is needed: Property Changed
> callback for "Paired" is *always* called after Proxy Added.
>
> Regards,
> Claudio

This patch can be applied now.

The patch "gdbus: Don't call property changed callback during client
init" fixes the problem that I reported.


Regards,
Claudio.

--===============8811639735738413461==--

