Content-Type: multipart/mixed; boundary="===============0317571489974377759=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: Re: [PATCH 6/8] gprs-context : Force use of atd99
Date: Fri, 15 Mar 2019 14:37:34 +0200
Message-ID: <CAPsFW+R+639dQ=CEac2U9iO=Zi9zyWLY_+UYurMTzVmtiUmatQ@mail.gmail.com>
In-Reply-To: <80971d3f-7b46-4da4-b11a-9dd21c021dc7@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0317571489974377759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 13/03/2019, Jonas Bonn <jonas@norrbonn.se> wrote:
> Hi,
>
> Could I get a clarification on the behaviour you see here?
>
> As I understand it, the SARA-R4 doesn't support the CGDATA command.
> That's fine as ofono will detect this and set use_atd99 in order to
> force the use of the ATD command as a fallback.

For some reason it does not detect it.

> Why do you need to force this setting in the below patch?  Does the
> CGDATA command not return ERROR?  What does it return?

Yes it throws an error and then ofono just gives up. I could check the
detailed error but I don't think it is of any use.

Regards,

Philippe

--===============0317571489974377759==--

