Content-Type: multipart/mixed; boundary="===============1718239459170805840=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: bug: NULL pointer access?
Date: Mon, 16 Jan 2012 09:37:35 +0100
Message-ID: <4F13E1CF.3050704@monom.org>
In-Reply-To: <4F05C471.4040105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1718239459170805840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 05.01.2012 16:40, Denis Kenzior wrote:
> Hi Daniel,
> =

> On 01/05/2012 08:59 AM, Daniel Wagner wrote:
>> Hi,
>>
>> I just managed to get this backtrace:
>>
>> ofonod[1808]: ++++++++ backtrace ++++++++
>> ofonod[1808]: #0  0x3366c0f500 in /lib64/libpthread.so.0
>> ofonod[1808]: #1  0x3366836285 in /lib64/libc.so.6
>> ofonod[1808]: #2  0x3366837b9b in /lib64/libc.so.6
>> ofonod[1808]: #3  0x336982fd85 in /lib64/libdbus-1.so.3
>> ofonod[1808]: #4  0x3369826e31 in /lib64/libdbus-1.so.3
>> ofonod[1808]: #5  0x336981b806 in /lib64/libdbus-1.so.3
>> ofonod[1808]: #6  0x4db083 in pri_activate_callback() at src/gprs.c:871
>> ofonod[1808]: #7  0x4611cf in ppp_connect() at drivers/atmodem/gprs-cont=
ext.c:101
>> ofonod[1808]: #8  0x447fdd in ppp_ipcp_up_notify() at gatchat/gatppp.c:4=
15
>> ofonod[1808]: #9  0x44bdbc in ipcp_up() at gatchat/ppp_ipcp.c:173
>> ofonod[1808]: #10 0x44911d in pppcp_this_layer_up() at gatchat/ppp_cp.c:=
322
>> ofonod[1808]: #11 0x449e5e in pppcp_generate_event() at gatchat/ppp_cp.c=
:690
>> ofonod[1808]: #12 0x44a68b in pppcp_process_packet() at gatchat/ppp_cp.c=
:967
>> ofonod[1808]: #13 0x447905 in ppp_receive() at gatchat/gatppp.c:224
>> ofonod[1808]: #14 0x446994 in new_bytes() at gatchat/gathdlc.c:301
>> ofonod[1808]: #15 0x43edf3 in received_data() at gatchat/gatio.c:124
>> ofonod[1808]: #16 0x3368844a7d in /lib64/libglib-2.0.so.0
>> ofonod[1808]: #17 0x3368845278 in /lib64/libglib-2.0.so.0
>> ofonod[1808]: #18 0x33688457c5 in /lib64/libglib-2.0.so.0
>> ofonod[1808]: #19 0x496c4e in main() at src/main.c:262
>> ofonod[1808]: #20 0x336682169d in /lib64/libc.so.6
>> ofonod[1808]: +++++++++++++++++++++++++++
>>
>>
>> static void pri_activate_callback(const struct ofono_error *error, void =
*data)
>> {
>> 	[...]
>>
>> 	__ofono_dbus_pending_reply(&ctx->pending,
>> 				dbus_message_new_method_return(ctx->pending));
>>
>> 	[...]
>> }
>>
>> I guess ctx->pending is NULL. =

>>
> =

> Sounds like it, but this makes no sense; pending is set right above the
> single instance of the driver operation with pri_activate_callback as
> the callback.  The only way for this to happen is if the callback is
> being called twice or some other interesting circumstance...
> =

> Can you duplicate this reliably?

No, not really. I was playing around with a new USB stick and I somehow
managed to trigger this one. Unfortunately, I can't remember what I did.
The only thing I remember was I restarted both daemon a few times.

I guess we can't much about this one then.

cheers,
daniel

--===============1718239459170805840==--

