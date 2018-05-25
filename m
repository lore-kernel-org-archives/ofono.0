Content-Type: multipart/mixed; boundary="===============1771082339824478634=="
MIME-Version: 1.0
From: Florent Beillonnet <florent.beillonnet@gmail.com>
Subject: Re: [PATCH 1/2] Adding the ofono_sim_initialized_notify function
 after ofono_sim_inserted_notify,
 as suggested by Denis Kenzior in this commit :
 54d56d763e40bc44c99a9b24aa0477bd373ea085
Date: Fri, 25 May 2018 11:15:18 +0200
Message-ID: <CACH22z7y-u8hUrzVM7443vz5vXZRSeTpxPEKWkPxB=rxrUYQZw@mail.gmail.com>
In-Reply-To: <3f11e274-de3d-4c68-dc8c-548fa5750a40@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1771082339824478634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I'm sorry, I really messed up with my last mails with the header and
description of the commits.

I tryed your change, and indeed it seems to work properly now, so I think
you can apply it.

Thank you !

Florent

2018-05-23 16:44 GMT+02:00 Denis Kenzior <denkenz@gmail.com>:

> Hi Florent,
>
> On 05/22/2018 08:08 AM, Florent Beillonnet wrote:
>
>> ---
>>   plugins/gemalto.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>
> You really shouldn't need to do this given that you have a URC inside
> gemalto_ciev_notify() that does exactly this already.
>
> No, I think there's a tiny bug in the core introduced by the commit you
> reference above.  Try this change?
>
> @@ -847,7 +847,7 @@ static void sim_enter_pin_cb(const struct ofono_error
> *error, void *data)
>
>         __ofono_dbus_pending_reply(&sim->pending, reply);
>
> -       if (sim->initialized)
> +       if (sim->initialized || error->type !=3D OFONO_ERROR_TYPE_NO_ERRO=
R)
>                 goto recheck;
>
>         if (sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN ||
>
> Regards,
> -Denis
>

--===============1771082339824478634==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcywgPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+SSYjMzk7bSBzb3JyeSwgSSByZWFsbHkgbWVzc2VkIHVwIHdpdGggbXkgbGFzdCBtYWlscyB3
aXRoIHRoZSBoZWFkZXIgYW5kIGRlc2NyaXB0aW9uIG9mIHRoZSBjb21taXRzLiA8YnI+PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5JIHRyeWVkIHlvdXIgY2hhbmdlLCBhbmQgaW5kZWVkIGl0IHNl
ZW1zIHRvIHdvcmsgcHJvcGVybHkgbm93LCBzbyBJIHRoaW5rIHlvdSBjYW4gYXBwbHkgaXQuPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFuayB5b3UgISA8YnI+PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5GbG9yZW50IDxicj4gPC9kaXY+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEi
Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxOC0wNS0yMyAxNjo0NCBHTVQrMDI6MDAg
RGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56
QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs8L3Nw
YW4+Ojxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAw
IDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBG
bG9yZW50LDxzcGFuIGNsYXNzPSIiPjxicj4KPGJyPgpPbiAwNS8yMi8yMDE4IDA4OjA4IEFNLCBG
bG9yZW50IEJlaWxsb25uZXQgd3JvdGU6PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij4KLS0tPGJyPgrCoCBwbHVnaW5zL2dlbWFsdG8uYyB8IDIgKys8YnI+
CsKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyk8YnI+CjwvYmxvY2txdW90ZT4KPGJy
Pjwvc3Bhbj4KWW91IHJlYWxseSBzaG91bGRuJiMzOTt0IG5lZWQgdG8gZG8gdGhpcyBnaXZlbiB0
aGF0IHlvdSBoYXZlIGEgVVJDIGluc2lkZSBnZW1hbHRvX2NpZXZfbm90aWZ5KCkgdGhhdCBkb2Vz
IGV4YWN0bHkgdGhpcyBhbHJlYWR5Ljxicj4KPGJyPgpObywgSSB0aGluayB0aGVyZSYjMzk7cyBh
IHRpbnkgYnVnIGluIHRoZSBjb3JlIGludHJvZHVjZWQgYnkgdGhlIGNvbW1pdCB5b3UgcmVmZXJl
bmNlIGFib3ZlLsKgIFRyeSB0aGlzIGNoYW5nZT88YnI+Cjxicj4KQEAgLTg0Nyw3ICs4NDcsNyBA
QCBzdGF0aWMgdm9pZCBzaW1fZW50ZXJfcGluX2NiKGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAq
ZXJyb3IsIHZvaWQgKmRhdGEpPGJyPgo8YnI+CsKgIMKgIMKgIMKgIF9fb2Zvbm9fZGJ1c19wZW5k
aW5nX3JlcGx5KCZhbXA7c2k8d2JyPm0tJmd0O3BlbmRpbmcsIHJlcGx5KTs8YnI+Cjxicj4KLcKg
IMKgIMKgIMKgaWYgKHNpbS0mZ3Q7aW5pdGlhbGl6ZWQpPGJyPgorwqAgwqAgwqAgwqBpZiAoc2lt
LSZndDtpbml0aWFsaXplZCB8fCBlcnJvci0mZ3Q7dHlwZSAhPSBPRk9OT19FUlJPUl9UWVBFX05P
X0VSUk9SKTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byByZWNoZWNrOzxicj4KPGJy
PgrCoCDCoCDCoCDCoCBpZiAoc2ltLSZndDtwaW5fdHlwZSA9PSBPRk9OT19TSU1fUEFTU1dPUkRf
U0lNX1BJTiB8fDxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Jsb2NrcXVvdGU+
PC9kaXY+PGJyPjwvZGl2Pgo=

--===============1771082339824478634==--

