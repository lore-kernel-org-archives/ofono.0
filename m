Content-Type: multipart/mixed; boundary="===============5607067225712712889=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/9] include: define initializer for ofono_call
Date: Tue, 01 Feb 2011 18:32:44 +0100
Message-ID: <1296581564.1520.279.camel@aeonflux>
In-Reply-To: <1296580370-2823-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5607067225712712889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> Some fields in struct ofono_call such as cnap_validity and clip_validity
> are not correctly initialized as 0 since this means they are present. If
> driver does not implement the necessary handlers, it might send to core
> an ofono_call signalling that cnap and clip are available when they are
> actually not.

all 9 patches have been applied. Thanks.

Regards

Marcel



--===============5607067225712712889==--

