Content-Type: multipart/mixed; boundary="===============1323959270023279235=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] drivers: support for auth NONE
Date: Thu, 04 Oct 2018 21:04:31 -0500
Message-ID: <fb51107c-ab61-2def-b24b-8b3130421d75@gmail.com>
In-Reply-To: <CAKSBH7FZYC2SGw6B=9vY=U=QqjVB8FR7=UXtsV8eXEO_m13rag@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1323959270023279235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>> All right.  But do you also want to mention this behavior in the D-Bus
>> documentation?  E.g. something to the effect of if AuthenticationMethod
>> is set to None, then username / password values are ignored?
> =

> gladly, but I didn't find a document for this.
> We are going to add it in the lte-api, but the only place I have found
> for the rest is in the
> connman-api.
> Is there some other documents?
> =


I don't believe so.

>> Given how closely related it is, it probably should be considered in the
>> same series.  This is one of those situations where we're messing with
>> the existing API and so all changes go in or none at all...  But given
>> that the drivers are expected to handle empty username/passwords
>> already, I'm okay leaving mbpi as is... but it might be a good idea to
>> fix it anyway...
> =

> I can fix it, but need to decide on a default then.
> It looks to me that 'none' would be a better default than 'chap'.
> The problem is that 'chap' is assumed so far and therefore it would be
> regressive.
> =


That's what I would do.  Use none if no password/username/auth method =

are provided.

Regards,
-Denis

--===============1323959270023279235==--

