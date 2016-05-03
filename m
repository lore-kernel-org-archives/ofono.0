Content-Type: multipart/mixed; boundary="===============7974850260521340745=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH 3/3] Add support for Sierra MC73xx QMI modems
Date: Tue, 03 May 2016 10:55:23 +0200
Message-ID: <8760uvpll0.fsf@nemi.mork.no>
In-Reply-To: <5728610D.5020105@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7974850260521340745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Martin Chaplet <m.chaplet@kerlink.fr> writes:

> Firstly, thank you for your previous patches which help me a lot.

And thank you for resurrecting it!

> On 02/05/2016 22:24, Bj=C3=B8rn Mork wrote:
>> Martin Chaplet <m.chaplet@kerlink.fr> writes:
>>
>>> +# Sierra MC73xx (wwan0 is buggy,
>> I suspect this is a raw-ip vs 802.3 issue. For example: wwan0 might be
>> configured for raw-ip if firmware autoconnect is enabled. You should be
>> able to detect this with a QMI_WDA "Get Data Format" request.
>>
>> In general, both interfaces 8 and 10 are usable on these modems.
>
> You are so right !
>
> However, WDA service is not yet supported in qmimodem.
> So I think we can keep the interface matching on QMI interface no 10 for
> now because  using interface 8 will imply changing its default link
> layer at each boot.
>
> What's your opinion ?

I believe there is no way around verifying the data format if you want
this to be robust. The 'data format' setting does not depend on modem
name or id or whatever.  It is configurable, and defaulting to the last
used value stored in NVRAM.  This setting will therefore vary among
identical modems, unless you force it yourself.

Also note that there is no 802.3 support at all in the newer MC74xx
series.  A 'raw-ip' mode was therefore added to the qmi_wwan driver in
Linux v4.5.  It changes the interface type though, so userspace
applications need to be aware.  Which is also one reason this driver
mode is never applied automatically - userspace must request it.

IMHO, it would be nice if the oFono support was flexible enough to
support all three generations Sierra Wireless QMI modems: MC77xx, MC73xx
and MC74xx.  But that's probably more suitable for a long term goal.
Initially concentrating on the MC73xx support makes sense.

FWIW, your approach looks fine to me.  But I'm definitely no oFono
expert :)


Bj=C3=B8rn

--===============7974850260521340745==--

