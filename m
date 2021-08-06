Content-Type: multipart/mixed; boundary="===============2781477000610101750=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Bug/Oversight in gatchat/gatresult.c with negative numbers
Date: Fri, 06 Aug 2021 10:02:18 -0500
Message-ID: <6d2dd964-db29-b092-a0e5-b4060854fae5@gmail.com>
In-Reply-To: <d9bb5080-c501-84e6-3d68-eead1020c830@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2781477000610101750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

> Yeah I think you are right and I am getting really irritated with them gi=
ving me =

> the run-around tbh.
> =


I sympathize, been there ;)

> =

> Yeah ok - what name do you suggest?

So there's a few things you can do actually:
- We do have g_at_result_next_unquoted_string.  You could try using that to =

obtain the negative <rsrp> and then just sscanf/strtol or whatever to conve=
rt it.
- We also have g_at_result_iter_raw_line() which can give you the raw resul=
t =

line.  It should be trivial to come up with some sscanf magic to parse the =
result.
- Just add a new g_at_result_iter_next_negative_number.  Or if you come up =
with =

a more descriptive word than negative, feel free.

> =

> Also there's a bigger problem here I think, which is that if I parse nega=
tive =

> values and try to pass them back via e.g. netmon interface then Ofono is =

> treating anything negative in there as an error.

oFono uses 27.007 as the interface between the driver and the core (and als=
o for =

DBus API).  If it isn't defined in 27.007, then your driver has to sanitize=
 it =

to a range that is defined in 27.007.  In your <rsrp> case any negative val=
ue =

would just be converted to a '0' which means < -140.

> =

> And the DBUS implementation is unsigned for values based on the thinking =
that AT =

> responses are non-negative.
> =


See above, the DBus implementation would be untouched.  If you need to =

*actually* know whether <rsrp> is -142 or other range that is not currently =

supported by 3GPP 27.007, then that is a bit nastier problem.

> So actually there are a number of invasive changes that seem to need to b=
e made =

> to support negative numbers?
> =


Hopefully not?

Regards,
-Denis
--===============2781477000610101750==--

