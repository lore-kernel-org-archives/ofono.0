Content-Type: multipart/mixed; boundary="===============3073444313943431206=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 5/7] text-telephony: add documentation
Date: Wed, 24 Nov 2010 09:25:29 -0600
Message-ID: <4CED2E69.8040806@gmail.com>
In-Reply-To: <1290535458-18786-6-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3073444313943431206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> +Properties	boolean	Powered [readwrite]
> +
> +			This property will enable or disable the text
> +			telephony feature in the modem.
> +
> +			Text telephony (TTY), also known as TDD, is a feature
> +			present in some modems that allow them to be used by
> +			hearing impaired people.

Marcel and I discussed this, and we decided we prefer 'Enabled' for the
property name.  You might also want to mention that this feature is also
known as 'CTM', Cellular Text Modem.

Regards,
-Denis

--===============3073444313943431206==--

