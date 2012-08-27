Content-Type: multipart/mixed; boundary="===============4744329318677595499=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [RFC] Multi-recipient SMS implementation proposals
Date: Mon, 27 Aug 2012 10:06:11 +0200
Message-ID: <503B2A73.5000504@linux.intel.com>
In-Reply-To: <1345847507.1779.26.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4744329318677595499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 25/08/2012 00:31, Marcel Holtmann wrote:
> Hi Guillaume,
>
> <snip>
>
>> 2-Modify existing SendMessage API in adding a new mms argument:
>> GDBUS_ASYNC_METHOD("SendMessage",
>>           GDBUS_ARGS({ "to", "s" }, { "text", "s" }, { "mms", "i" }),
>>           GDBUS_ARGS({ "path", "o" }),
>>           sms_send_message)
> oFono 1.x has a stable API. Why are you proposing to break the API?

Ok, and what is your opinion about the first solution?

Kind regards,
Guillaume

--===============4744329318677595499==--

