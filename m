Content-Type: multipart/mixed; boundary="===============2705508725728744385=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: Re: nokia-modem (N900) not detected after migration to udevng
Date: Mon, 11 Sep 2017 08:44:05 -0700
Message-ID: <20170911154405.GB3@computer.craftyguy.net>
In-Reply-To: <a855fa5d-7998-1151-acb6-bd7f96378229@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2705508725728744385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
The following patches are also necessary to help bring up the isimodem
device, I don't think they were accepted/merged.
If you need anything else to help get these in, please let me know!
https://lists.ofono.org/pipermail/ofono/2017-September/017463.html
https://lists.ofono.org/pipermail/ofono/2017-September/017465.html
https://lists.ofono.org/pipermail/ofono/2017-September/017483.html

-Clayton



On Sat, Sep 09, 2017 at 01:29:33PM -0500, Denis Kenzior wrote:
>Hi Clayton,
>
>On 09/09/2017 12:58 PM, Clayton Craft wrote:
>>Ok, now the modem is initializing (after applying 3 patches from
>>Jonas), I get this seg fault in ofonod when I run the "enable-modem" test
>>script:
>>
>
>See https://lists.ofono.org/pipermail/ofono/2017-May/017311.html
>
>Regards,
>-Denis


--===============2705508725728744385==--

