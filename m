Content-Type: multipart/mixed; boundary="===============8990870638794681251=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Update interface with variable port numbers?
Date: Wed, 12 Jan 2011 07:57:51 -0800
Message-ID: <1294847871.3873.76.camel@aeonflux>
In-Reply-To: <4D2D5F61.5040404@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8990870638794681251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

> we could probably use an update in the push_notification_register_agent
> in plugins/push-notification.c so that it would be possible to specify =

> port numbers instead of them being hardcoded with
> =

> #define WAP_PUSH_SRC_PORT 9200
> #define WAP_PUSH_DST_PORT 2948
> =

> We would like to be able to use the
> oma-ilp		7276/tcp    OMA Internal Location Protocol
> =

> specified on
> http://www.iana.org/assignments/port-numbers
> =

> This could also be used for other WAP based services.
> =

> Is this something that you would agree would be useful and we could add =

> to the TODO list?

what is the content of these messages? For WAP Push it is clearly
defined. Are these also WAP Push PDUs?

Regards

Marcel



--===============8990870638794681251==--

