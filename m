Content-Type: multipart/mixed; boundary="===============9023066809833514443=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] Multi-recipient SMS implementation proposals
Date: Fri, 24 Aug 2012 15:31:47 -0700
Message-ID: <1345847507.1779.26.camel@aeonflux>
In-Reply-To: <50375283.9080600@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9023066809833514443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

<snip>

> 2-Modify existing SendMessage API in adding a new mms argument:
> GDBUS_ASYNC_METHOD("SendMessage",
>          GDBUS_ARGS({ "to", "s" }, { "text", "s" }, { "mms", "i" }),
>          GDBUS_ARGS({ "path", "o" }),
>          sms_send_message)

oFono 1.x has a stable API. Why are you proposing to break the API?

Regards

Marcel



--===============9023066809833514443==--

