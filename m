Content-Type: multipart/mixed; boundary="===============9080956026626676391=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: Re: [PATCH 1/1] qmi: support SMS receive on Quectel EC21
Date: Tue, 17 Oct 2017 13:41:34 +0200
Message-ID: <20171017134134.0d70b32e@lazus.yip>
In-Reply-To: <f8d6bb37-b59b-cea7-5ef9-56b0e7072e14@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9080956026626676391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

> Could you explain what you are trying to do here?  Why would you
> clear the SMS storage every time the modem powers up?
> =

> I also don't see that ofono actually supports deleting messages from
> the modem's storage... if you know how this is supposed to work,
> please enlighten me.

the Gobi2000 doesn't accept the routes with TRANSFER_AND_ACK nor
STORAGE_TYPE_NONE.

Reading out the store is also useful if the modem is receiving any
SMS while ofono isn't runing. E.g. while booting, the sms would never
made it to ofono.

I don't know (yet) how the different routes are working in detail. This
is on my list. But I've faced edge cases when the NV was full, the
modem rejects receiving any messages, regardless if the modem should
save it to it.

Best,
lynxis
-- =

Alexander Couzens

mail: lynxis(a)fe80.eu
jabber: lynxis(a)fe80.eu
mobile: +4915123277221
gpg: 390D CF78 8BF9 AA50 4F8F  F1E2 C29E 9DA6 A0DF 8604

--===============9080956026626676391==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.sig"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUVCQ2dBZEZpRUVPUTNQZUl2NXFs
QlBqL0hpd3A2ZHBxRGZoZ1FGQWxubDdHOEFDZ2tRd3A2ZHBxRGYKaGdTWldnLy9hbFRIdU9FNFRO
Z3UrZWVMeWtvT3NSeDZDRyt1TFJYaTEvSmFYa1gwdnZ0dUd0UWp6bmdXKzZycQp4WHZtWDE2M2hN
akk3a0ZteUh4cUdLbjlBMVQ1UG85Wi91TS9LeU5CcWQ3YmJUeWJGZHZVa1RlaytBNXVGQ2NGCjY0
WGVlQy82MStIdGh4QWdkMyt2TUNlWFQwbEN0VlVqb2FUS0psNnJaalhFNkxZWTJsVU1SQVpyTFA2
Rmxia3QKSFFKTytUbVU4Mi94aUcvMThTTmp5dWpTWVRwREs3N05lNXM2VkM2MStCdC93WmRTSWYz
TWtWZDJ5UmlDZlZIcwpQN3pXeG1JZk12YU1PWmhJc2ZrajRGOUpEZjNXK0h2OUF4TFYzV1RIMTdD
WW9Ea25WKy9WSitGLzF2UG9ORkpsCnkvSlFwcHg0K2Z4eE1PdU5JbnhHOGtFUWFtNkhtVHN4eWdV
UnZKL3VuTjR1T01YdlhONHNMTlNzRU81UlAveVIKUkNGc3BienVTN3FBWGF0dGJoTXIxajhJM1JG
bGVDK2VPRTk1RENTWHFXZVppenVpK3owU2F1TW1kRlRPM3cycgo3anF4cmtWaFdqbmFuV3BBMDN4
K0pVYkVKT2Izc053TUVuQU1nZ3U4MUV4ZG1EYmJhY0NxVzFjcXF2T2dndlZpCkNzaGd1bWNTeHdm
STlGQ0RBYlFvY3ZNcWE5TnBFcFcyNVVMcERDYlZEUjUzU3NHSkdtL3phQW1FRzh3SlpLbkcKNW9B
VzcvNEJYc2lkcGJ6bStQTkg2KzVNTmNmRkMxb0pJTGNXTHBmdVloWldZaDJCeVhKNlZuK0hub05s
T3VTdgpuSU9HSUNaYmt6ejFtYjRzTmNpMGNEMDh5SC9zZEtOZ3ZoMGlBVHQvdWZvZXBoOWMvSkE9
Cj1PWFJ2Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============9080956026626676391==--

