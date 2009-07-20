Content-Type: multipart/mixed; boundary="===============5210709671777599833=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] Cache EF-PNN, EF-OPL sim files on disk.
Date: Mon, 20 Jul 2009 16:56:39 +0200
Message-ID: <fb249edb0907200756u6cbe701fhea3e82b50eff7567@mail.gmail.com>
In-Reply-To: <1248099857.4549.124.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5210709671777599833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/7/20 Marcel Holtmann <marcel@holtmann.org>:
>> This uses plain files in /var/cache/ofono for storing contents of the
>> operator lists to avoid possibly numerous queries to the SIM on every
>> startup. =C2=A0Files are indexed with IMSI. =C2=A0I'm not 100% sure abou=
t the
>> autoconf magic.
>
> please have a look into BlueZ or ConnMan and use STORAGEDIR for the base
> path of /var/lib/ofono.

Okay.

>
> Can we just use GKeyFile to store these files? It would make reading and
> adding them a lot easier.

I didn't know about GKeyFile but I considered BlueZ textfile after
Denis suggested them.  The values in GKeyFile are UTF-8 encoded with
some characters reserved so we would need either very heavy escaping
or storing the SIM file contents hex encoded.  Keys would be only
perhaps "FileInfo" and "Record1"..."RecordN" because SIM files are
nothing like key-value pairs.  If you think the reading convenience is
worth the parsing overhead, then I can change the patch to use
GKeyFile or json or xml.

Supposedly this is only a form caching so there shouldn't be need for
reading or adding these files, they can get overwritten at any time.

Regards

--===============5210709671777599833==--

