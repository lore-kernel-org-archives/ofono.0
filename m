Content-Type: multipart/mixed; boundary="===============6749253100903853142=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: bug: NULL pointer access?
Date: Thu, 05 Jan 2012 15:59:35 +0100
Message-ID: <4F05BAD7.9050206@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6749253100903853142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I just managed to get this backtrace:

ofonod[1808]: ++++++++ backtrace ++++++++
ofonod[1808]: #0  0x3366c0f500 in /lib64/libpthread.so.0
ofonod[1808]: #1  0x3366836285 in /lib64/libc.so.6
ofonod[1808]: #2  0x3366837b9b in /lib64/libc.so.6
ofonod[1808]: #3  0x336982fd85 in /lib64/libdbus-1.so.3
ofonod[1808]: #4  0x3369826e31 in /lib64/libdbus-1.so.3
ofonod[1808]: #5  0x336981b806 in /lib64/libdbus-1.so.3
ofonod[1808]: #6  0x4db083 in pri_activate_callback() at src/gprs.c:871
ofonod[1808]: #7  0x4611cf in ppp_connect() at drivers/atmodem/gprs-context=
.c:101
ofonod[1808]: #8  0x447fdd in ppp_ipcp_up_notify() at gatchat/gatppp.c:415
ofonod[1808]: #9  0x44bdbc in ipcp_up() at gatchat/ppp_ipcp.c:173
ofonod[1808]: #10 0x44911d in pppcp_this_layer_up() at gatchat/ppp_cp.c:322
ofonod[1808]: #11 0x449e5e in pppcp_generate_event() at gatchat/ppp_cp.c:690
ofonod[1808]: #12 0x44a68b in pppcp_process_packet() at gatchat/ppp_cp.c:967
ofonod[1808]: #13 0x447905 in ppp_receive() at gatchat/gatppp.c:224
ofonod[1808]: #14 0x446994 in new_bytes() at gatchat/gathdlc.c:301
ofonod[1808]: #15 0x43edf3 in received_data() at gatchat/gatio.c:124
ofonod[1808]: #16 0x3368844a7d in /lib64/libglib-2.0.so.0
ofonod[1808]: #17 0x3368845278 in /lib64/libglib-2.0.so.0
ofonod[1808]: #18 0x33688457c5 in /lib64/libglib-2.0.so.0
ofonod[1808]: #19 0x496c4e in main() at src/main.c:262
ofonod[1808]: #20 0x336682169d in /lib64/libc.so.6
ofonod[1808]: +++++++++++++++++++++++++++


static void pri_activate_callback(const struct ofono_error *error, void *da=
ta)
{
	[...]

	__ofono_dbus_pending_reply(&ctx->pending,
				dbus_message_new_method_return(ctx->pending));

	[...]
}

I guess ctx->pending is NULL. =


cheers,
daniel

--===============6749253100903853142==--

