Content-Type: multipart/mixed; boundary="===============2147565929424766337=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v2 1/6] atmodem: create struct atmodem_gprs
Date: Mon, 03 May 2010 09:39:46 +0300
Message-ID: <87iq75a3pp.fsf@potku.valot.fi>
In-Reply-To: <1272634482.22838.193.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2147565929424766337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Kalle,

Hi Marcel,

> I don't really like this. You only need to catch the CGREG anyway so we
> might just wanna add some indication method. Similar to what we have for
> network registration with ofono_netreg_status_notify.
>
> Then the messed up CGREG from Huawei modem doesn't dictate the whole
> simple one GAtChat approach. It is really their fault with no sending
> these on the proper AT command channel. No need to make other drivers
> suffer.

Sounds very good to me. I didn't even think about this because I was
under (false) impression that all AT commands must be handled in atmodem
driver.

I'm travelling the next two weeks, so it might take a while before I
have v3 ready.

-- =

Kalle Valo

--===============2147565929424766337==--

