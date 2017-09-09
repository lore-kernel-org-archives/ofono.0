Content-Type: multipart/mixed; boundary="===============8626971213640796023=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: Re: nokia-modem (N900) not detected after migration to udevng
Date: Sat, 09 Sep 2017 13:34:04 -0700
Message-ID: <20170909203404.GG3@computer.craftyguy.net>
In-Reply-To: <a855fa5d-7998-1151-acb6-bd7f96378229@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8626971213640796023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Would it be possible to merge the three patches that Jonas produced,
so at least the modem will make it through the initialization phase? I
will take a long, hard look at some point into the patchset you linked
in your other mail, and one day I might try to fix it, but being able
to avoid the previous init problems when that day comes would be really nic=
e :)

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


--===============8626971213640796023==--

