Content-Type: multipart/mixed; boundary="===============0565203833186709877=="
MIME-Version: 1.0
From: John.Mathew@elektrobit.com
Subject: RE: [PATCH] voicecall: Add EmergencyCall property.
Date: Thu, 11 Nov 2010 22:22:08 +0200
Message-ID: <FE1DB9979BF5A743BEB836613423CAD8CD4A1C@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <4CDC0B2D.6010407@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0565203833186709877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Denis,

> +static gboolean voicecall_isemergency(struct voicecall *v)

> Please use voicecall_is_emergency

Will change

> +{
> +     struct ofono_call *call =3D v->call;
> +     const char *lineid_str;
> +
> +     lineid_str =3D phone_number_to_string(&call->phone_number);
> +
> +     if (g_slist_find_custom(v->vc->en_list, lineid_str,
> +                                             (GCompareFunc) strcmp))

> As a general rule, the only function casting we allow is for GFunc use of=
 g_free.  I really prefer that you write a separate function here.

I had two options, to write a function comparing the string, or to use strc=
mp. A search in ofono source showed me 2 instances where strcmp is used and=
 I followed it here too.

I can write a function to compare the phone number, and will make a patch.

> +             return TRUE;
> +     else

> Please drop the else, it isn't actually required and makes the code sligh=
tly cleaner.

Agreed, will make the change.

> +             return FALSE;
> +}
> +
>  static void append_voicecall_properties(struct voicecall *v,
>                                       DBusMessageIter *dict)
>  {
> @@ -322,7 +336,8 @@ static void append_voicecall_properties(struct voicec=
all *v,
>       const char *status;
>       const char *callerid;
>       const char *timestr;
> -     ofono_bool_t mpty;
> +     ofono_bool_t mpt;

> Is there a reason you're changing this variable name?

Will recity this, came in as typo mistake.

> +     dbus_bool_t emergency_call;
> =

>       status =3D call_status_to_string(call->status);
>       callerid =3D phone_number_to_string(&call->phone_number);
> @@ -358,6 +373,14 @@ static void append_voicecall_properties(struct voice=
call *v,
>       if (v->icon_id)
>               ofono_dbus_dict_append(dict, "Icon", DBUS_TYPE_BYTE,
>                                       &v->icon_id);
> +
> +     if (voicecall_isemergency(v))
> +                     emergency_call =3D TRUE;
> +     else
> +                     emergency_call =3D FALSE;
> +
> +     ofono_dbus_dict_append(dict, "EmergencyCall", DBUS_TYPE_BOOLEAN,
> +                                     &emergency_call);
>  }
> =

>  static DBusMessage *voicecall_get_properties(DBusConnection *conn, @@
> -722,6 +745,15 @@ static void voicecall_set_call_lineid(struct voicecall =
*v,
>                                               OFONO_VOICECALL_INTERFACE,
>                                               "LineIdentification",
>                                               DBUS_TYPE_STRING, &lineid_s=
tr);
> +
> +     if (voicecall_isemergency(v)) {
> +             dbus_bool_t emergency_call =3D TRUE;

> In general we prefer an empty line after every variable declaration block.

Sure will change

> +             ofono_dbus_signal_property_changed(conn, path,
> +                                             OFONO_VOICECALL_INTERFACE,
> +                                             "EmergencyCall",
> +                                             DBUS_TYPE_BOOLEAN,
> +                                             &emergency_call);
> +     }
>  }
> =

>  static gboolean voicecall_dbus_register(struct voicecall *v)

Regards,
John =



--===============0565203833186709877==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDMuMi8vRU4iPgo8SFRNTD4K
PEhFQUQ+CjxNRVRBIEhUVFAtRVFVSVY9IkNvbnRlbnQtVHlwZSIgQ09OVEVOVD0idGV4dC9odG1s
OyBjaGFyc2V0PWlzby04ODU5LTEiPgo8TUVUQSBOQU1FPSJHZW5lcmF0b3IiIENPTlRFTlQ9Ik1T
IEV4Y2hhbmdlIFNlcnZlciB2ZXJzaW9uIDYuNS43NjU0LjEyIj4KPFRJVExFPlJFOiBbUEFUQ0hd
IHZvaWNlY2FsbDogQWRkIEVtZXJnZW5jeUNhbGwgcHJvcGVydHkuPC9USVRMRT4KPC9IRUFEPgo8
Qk9EWT4KPCEtLSBDb252ZXJ0ZWQgZnJvbSB0ZXh0L3BsYWluIGZvcm1hdCAtLT4KPEJSPgoKPFA+
PEZPTlQgU0laRT0yPkhpIERlbmlzLDxCUj4KPEJSPgomZ3Q7ICtzdGF0aWMgZ2Jvb2xlYW4gdm9p
Y2VjYWxsX2lzZW1lcmdlbmN5KHN0cnVjdCB2b2ljZWNhbGwgKnYpPEJSPgo8QlI+CiZndDsgUGxl
YXNlIHVzZSB2b2ljZWNhbGxfaXNfZW1lcmdlbmN5PEJSPgo8QlI+CldpbGwgY2hhbmdlPEJSPgo8
QlI+CiZndDsgK3s8QlI+CiZndDsgKyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzdHJ1Y3Qgb2Zv
bm9fY2FsbCAqY2FsbCA9IHYtJmd0O2NhbGw7PEJSPgomZ3Q7ICsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgY29uc3QgY2hhciAqbGluZWlkX3N0cjs8QlI+CiZndDsgKzxCUj4KJmd0OyArJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IGxpbmVpZF9zdHIgPSBwaG9uZV9udW1iZXJfdG9fc3RyaW5nKCZh
bXA7Y2FsbC0mZ3Q7cGhvbmVfbnVtYmVyKTs8QlI+CiZndDsgKzxCUj4KJmd0OyArJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IGlmIChnX3NsaXN0X2ZpbmRfY3VzdG9tKHYtJmd0O3ZjLSZndDtlbl9s
aXN0LCBsaW5laWRfc3RyLDxCUj4KJmd0OyArJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IChHQ29tcGFyZUZ1bmMpIHN0cmNtcCkpPEJSPgo8QlI+CiZndDsgQXMgYSBnZW5lcmFs
IHJ1bGUsIHRoZSBvbmx5IGZ1bmN0aW9uIGNhc3Rpbmcgd2UgYWxsb3cgaXMgZm9yIEdGdW5jIHVz
ZSBvZiBnX2ZyZWUuJm5ic3A7IEkgcmVhbGx5IHByZWZlciB0aGF0IHlvdSB3cml0ZSBhIHNlcGFy
YXRlIGZ1bmN0aW9uIGhlcmUuPEJSPgo8QlI+CkkgaGFkIHR3byBvcHRpb25zLCB0byB3cml0ZSBh
IGZ1bmN0aW9uIGNvbXBhcmluZyB0aGUgc3RyaW5nLCBvciB0byB1c2Ugc3RyY21wLiBBIHNlYXJj
aCBpbiBvZm9ubyBzb3VyY2Ugc2hvd2VkIG1lIDIgaW5zdGFuY2VzIHdoZXJlIHN0cmNtcCBpcyB1
c2VkIGFuZCBJIGZvbGxvd2VkIGl0IGhlcmUgdG9vLjxCUj4KPEJSPgpJIGNhbiB3cml0ZSBhIGZ1
bmN0aW9uIHRvIGNvbXBhcmUgdGhlIHBob25lIG51bWJlciwgYW5kIHdpbGwgbWFrZSBhIHBhdGNo
LjxCUj4KPEJSPgomZ3Q7ICsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuIFRSVUU7PEJSPgomZ3Q7ICsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZWxzZTxCUj4KPEJSPgomZ3Q7IFBsZWFzZSBkcm9wIHRo
ZSBlbHNlLCBpdCBpc24ndCBhY3R1YWxseSByZXF1aXJlZCBhbmQgbWFrZXMgdGhlIGNvZGUgc2xp
Z2h0bHkgY2xlYW5lci48QlI+CjxCUj4KQWdyZWVkLCB3aWxsIG1ha2UgdGhlIGNoYW5nZS48QlI+
CjxCUj4KJmd0OyArJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldHVybiBGQUxTRTs8QlI+CiZndDsgK308QlI+
CiZndDsgKzxCUj4KJmd0OyZuYnNwOyBzdGF0aWMgdm9pZCBhcHBlbmRfdm9pY2VjYWxsX3Byb3Bl
cnRpZXMoc3RydWN0IHZvaWNlY2FsbCAqdiw8QlI+CiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgREJ1c01lc3NhZ2VJdGVyICpkaWN0
KTxCUj4KJmd0OyZuYnNwOyB7PEJSPgomZ3Q7IEBAIC0zMjIsNyArMzM2LDggQEAgc3RhdGljIHZv
aWQgYXBwZW5kX3ZvaWNlY2FsbF9wcm9wZXJ0aWVzKHN0cnVjdCB2b2ljZWNhbGwgKnYsPEJSPgom
Z3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNvbnN0IGNoYXIgKnN0YXR1
czs8QlI+CiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgY29uc3QgY2hh
ciAqY2FsbGVyaWQ7PEJSPgomZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IGNvbnN0IGNoYXIgKnRpbWVzdHI7PEJSPgomZ3Q7IC0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
b2Zvbm9fYm9vbF90IG1wdHk7PEJSPgomZ3Q7ICsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgb2Zv
bm9fYm9vbF90IG1wdDs8QlI+CjxCUj4KJmd0OyBJcyB0aGVyZSBhIHJlYXNvbiB5b3UncmUgY2hh
bmdpbmcgdGhpcyB2YXJpYWJsZSBuYW1lPzxCUj4KPEJSPgpXaWxsIHJlY2l0eSB0aGlzLCBjYW1l
IGluIGFzIHR5cG8gbWlzdGFrZS48QlI+CjxCUj4KJmd0OyArJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IGRidXNfYm9vbF90IGVtZXJnZW5jeV9jYWxsOzxCUj4KJmd0OzxCUj4KJmd0OyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzdGF0dXMgPSBjYWxsX3N0YXR1c190b19zdHJp
bmcoY2FsbC0mZ3Q7c3RhdHVzKTs8QlI+CiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgY2FsbGVyaWQgPSBwaG9uZV9udW1iZXJfdG9fc3RyaW5nKCZhbXA7Y2FsbC0mZ3Q7
cGhvbmVfbnVtYmVyKTs8QlI+CiZndDsgQEAgLTM1OCw2ICszNzMsMTQgQEAgc3RhdGljIHZvaWQg
YXBwZW5kX3ZvaWNlY2FsbF9wcm9wZXJ0aWVzKHN0cnVjdCB2b2ljZWNhbGwgKnYsPEJSPgomZ3Q7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmICh2LSZndDtpY29uX2lkKTxC
Uj4KJmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBvZm9ub19kYnVzX2RpY3RfYXBwZW5k
KGRpY3QsICZxdW90O0ljb24mcXVvdDssIERCVVNfVFlQRV9CWVRFLDxCUj4KJmd0OyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmYW1wO3Yt
Jmd0O2ljb25faWQpOzxCUj4KJmd0OyArPEJSPgomZ3Q7ICsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgaWYgKHZvaWNlY2FsbF9pc2VtZXJnZW5jeSh2KSk8QlI+CiZndDsgKyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBlbWVyZ2Vu
Y3lfY2FsbCA9IFRSVUU7PEJSPgomZ3Q7ICsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZWxzZTxC
Uj4KJmd0OyArJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IGVtZXJnZW5jeV9jYWxsID0gRkFMU0U7PEJSPgomZ3Q7ICs8QlI+CiZn
dDsgKyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBvZm9ub19kYnVzX2RpY3RfYXBwZW5kKGRpY3Qs
ICZxdW90O0VtZXJnZW5jeUNhbGwmcXVvdDssIERCVVNfVFlQRV9CT09MRUFOLDxCUj4KJmd0OyAr
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZhbXA7ZW1lcmdl
bmN5X2NhbGwpOzxCUj4KJmd0OyZuYnNwOyB9PEJSPgomZ3Q7PEJSPgomZ3Q7Jm5ic3A7IHN0YXRp
YyBEQnVzTWVzc2FnZSAqdm9pY2VjYWxsX2dldF9wcm9wZXJ0aWVzKERCdXNDb25uZWN0aW9uICpj
b25uLCBAQDxCUj4KJmd0OyAtNzIyLDYgKzc0NSwxNSBAQCBzdGF0aWMgdm9pZCB2b2ljZWNhbGxf
c2V0X2NhbGxfbGluZWlkKHN0cnVjdCB2b2ljZWNhbGwgKnYsPEJSPgomZ3Q7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE9GT05PX1ZPSUNFQ0FMTF9JTlRF
UkZBQ0UsPEJSPgomZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7ICZxdW90O0xpbmVJZGVudGlmaWNhdGlvbiZxdW90Oyw8QlI+CiZndDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgREJVU19UWVBFX1NUUklORywg
JmFtcDtsaW5laWRfc3RyKTs8QlI+CiZndDsgKzxCUj4KJmd0OyArJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IGlmICh2b2ljZWNhbGxfaXNlbWVyZ2VuY3kodikpIHs8QlI+CiZndDsgKyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBkYnVzX2Jvb2xfdCBlbWVyZ2VuY3lfY2FsbCA9IFRSVUU7PEJSPgo8QlI+CiZndDsg
SW4gZ2VuZXJhbCB3ZSBwcmVmZXIgYW4gZW1wdHkgbGluZSBhZnRlciBldmVyeSB2YXJpYWJsZSBk
ZWNsYXJhdGlvbiBibG9jay48QlI+CjxCUj4KU3VyZSB3aWxsIGNoYW5nZTxCUj4KPEJSPgomZ3Q7
ICsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgb2Zvbm9fZGJ1c19zaWduYWxfcHJvcGVydHlfY2hhbmdlZChjb25u
LCBwYXRoLDxCUj4KJmd0OyArJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE9G
T05PX1ZPSUNFQ0FMTF9JTlRFUkZBQ0UsPEJSPgomZ3Q7ICsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgJnF1b3Q7RW1lcmdlbmN5Q2FsbCZxdW90Oyw8QlI+CiZndDsgKyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBEQlVTX1RZUEVfQk9PTEVBTiw8QlI+CiZn
dDsgKyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmYW1wO2VtZXJnZW5jeV9j
YWxsKTs8QlI+CiZndDsgKyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9PEJSPgomZ3Q7Jm5ic3A7
IH08QlI+CiZndDs8QlI+CiZndDsmbmJzcDsgc3RhdGljIGdib29sZWFuIHZvaWNlY2FsbF9kYnVz
X3JlZ2lzdGVyKHN0cnVjdCB2b2ljZWNhbGwgKnYpPEJSPgo8QlI+ClJlZ2FyZHMsPEJSPgpKb2hu
PEJSPgo8QlI+CjwvRk9OVD4KPC9QPgoKPC9CT0RZPgo8L0hUTUw+
--===============0565203833186709877==--

