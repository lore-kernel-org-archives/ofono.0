Content-Type: multipart/mixed; boundary="===============4437605044233084729=="
MIME-Version: 1.0
From: Marko Sulejic <marko.sulejic@hale.at>
Subject: Re: HE910 + ofono: "Activating context failed with error: Unknown
 error type"
Date: Wed, 01 Jul 2015 09:11:01 +0200
Message-ID: <55939285.1000306@hale.at>
In-Reply-To: <558DD9E0.3030100@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4437605044233084729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Am 2015-06-27 um 01:01 schrieb Denis Kenzior:
> Hi Marko,

Hi Denis,

>
> >
>> At the end of a PPP connection, garbage was passed in to the AT command
>> parser on the modem chat.
>
> Well, the modem should not be passing in garbage in the first place :)

Yeah, but it unfortunately does so :)

>
>> This garbage contained a doublequote, which switched the AT syntax
>> parser into string mode.
>> However, because no second doublequote arrived, it stayed in this mode,
>> and kept returning UNSURE result.
>>
>
> Do you have a trace/hexdump of what is passed on to the GAtChat object?

Before receiving  the "NO CARRIER" signal,
the modem leaves the data mode
and enters the chat mode (apparently too early).

In my log you can see that it gets some leftovers
of a PPP package,including an opening double quote
  ... but it never gets the closing one, and therefore
oFono is not responding any more.

Here is the log:
(the modem has already established a data connection,
and I pull out the SIM card of its slot)

ofonod[2816]: modem.c(501):modem_change_state() old state: 3, new state: 1
ofonod[2816]: modem.c(414):flush_atoms()
ofonod[2816]: push-notification.c(166):push_notification_cleanup() 0x5519f8
ofonod[2816]: smart-messaging.c(291):smart_messaging_cleanup() 0x551e78
ofonod[2816]: network.c(1173):__ofono_netreg_remove_status_watch() 0x551178
ofonod[2816]: sms.c(1719):sms_remove() atom: 0x55a278
ofonod[2816]: phonebook.c(527):phonebook_remove() atom: 0x557000
ofonod[2816]: gprs.c(2279):gprs_context_unregister() 0x54f3c0, 0x54f290
ofonod[2816]: gprs.c(2413):gprs_context_remove() atom: 0x54f3e0
ofonod[2816]: gprs-context.c(422):at_gprs_context_remove()
kernel: [ 1711.579055] PM: Removing info for No Bus:ppp0
ofonod[2816]: gprs.c(2644):gprs_unregister() 0x54f290
ofonod[2816]: network.c(1173):__ofono_netreg_remove_status_watch() 0x551178
ofonod[2816]: gprs.c(2683):gprs_remove() atom: 0x54f2f8
ofonod[2816]: message-waiting.c(1088):mw_remove() atom: 0x54edf8
ofonod[2816]: call-barring.c(1039):call_barring_remove() atom: 0x54eb60
ofonod[2816]: call-meter.c(718):call_meter_remove() atom: 0x54d398
ofonod[2816]: call-settings.c(1393):call_settings_remove() atom: 0x54d2d8
ofonod[2816]: call-forwarding.c(1465):call_forwarding_remove() atom: =

0x54d200
ofonod[2816]: ussd.c(811):ussd_remove() atom: 0x5511e0
ofonod[2816]: sim.c(2720):ofono_sim_remove_spn_watch() 0x52dd10
ofonod[2816]: network.c(1836):netreg_remove() atom: 0x550f70
ofonod[2816]: voicecall.c(2787):voicecall_remove() atom: 0x52bf80
ofonod[2816]: udevng.c(979):remove_device() /sys/devices/virtual/net/ppp0
ofonod[2816]: udev.c(428):udev_event() subsystem net remove
ofonod[2816]: udev.c(337):remove_modem() /devices/virtual/net/ppp0
ofonod[2816]: udev.c(442):udev_event() subsystem net finished
ofonod[2816]: Aux: < \r\n
ofonod[2816]: Aux: < +CGEV: NW DEACT IP, "10.183.107.173", 1\r\n
ofonod[2816]: Modem: < ~\377}#\300!}%}"} }$Y(~
ofonod[2816]: Modem: < \r\nNO CARRIER\r\n


>
>> I think this is an major issue that should be fixed in oFono.
>> The syntax parser has to be extended to handle such cases.
>>
>
> Any suggestions on how oFono should detect this condition?

Here is our "quick" solution to this problem.

--- gatchat.c (f83233d)
+++ gatchat.c (a3cb2b2)
@@ -957,6 +957,11 @@
      g_at_io_set_debug(chat->io, chat->debugf, chat->debug_data);
      g_at_io_set_read_handler(chat->io, new_bytes, chat);

+    /* Prevent garbage that arrives from the late data connection to
+     * switch the AT syntax parser to string mode (when it contains a =

doublequote) */
+    if (chat->syntax->set_hint)
+        chat->syntax->set_hint(chat->syntax, G_AT_SYNTAX_EXPECT_GARBAGE);
+
      if (g_queue_get_length(chat->command_queue) > 0)
          chat_wakeup_writer(chat);
  }


--- gatsyntax.c (359f790)
+++ gatsyntax.c (a3cb2b2)
@@ -57,6 +57,8 @@
      GSM_PERMISSIVE_STATE_PROMPT,
      GSM_PERMISSIVE_STATE_GUESS_SHORT_PROMPT,
      GSM_PERMISSIVE_STATE_SHORT_PROMPT,
+    GSM_PERMISSIVE_STATE_GUESS_GARBAGE,
+    GSM_PERMISSIVE_STATE_GARBAGE,
  };

  static void gsmv1_hint(GAtSyntax *syntax, GAtSyntaxExpectHint hint)
@@ -270,6 +272,8 @@
          syntax->state =3D GSM_PERMISSIVE_STATE_GUESS_PDU;
      else if (hint =3D=3D G_AT_SYNTAX_EXPECT_SHORT_PROMPT)
          syntax->state =3D GSM_PERMISSIVE_STATE_GUESS_SHORT_PROMPT;
+    else if (hint =3D=3D G_AT_SYNTAX_EXPECT_GARBAGE)
+        syntax->state =3D GSM_PERMISSIVE_STATE_GUESS_GARBAGE;
  }

  static GAtSyntaxResult gsm_permissive_feed(GAtSyntax *syntax,
@@ -358,6 +362,21 @@
              syntax->state =3D GSM_PERMISSIVE_STATE_RESPONSE;
              return G_AT_SYNTAX_RESULT_UNSURE;

+        case GSM_PERMISSIVE_STATE_GUESS_GARBAGE:
+            if (byte !=3D '\r' && byte !=3D '\n')
+                syntax->state =3D GSM_PERMISSIVE_STATE_GARBAGE;
+            break;
+
+        case GSM_PERMISSIVE_STATE_GARBAGE:
+            if (byte =3D=3D '\r') {
+                syntax->state =3D GSM_PERMISSIVE_STATE_IDLE;
+
+                i +=3D 1;
+                res =3D G_AT_SYNTAX_RESULT_GARBAGE;
+                goto out;
+            }
+            break;
+
          default:
              break;
          };


--- gatsyntax.h (21f9da9)
+++ gatsyntax.h (a3cb2b2)
@@ -30,7 +30,8 @@
      G_AT_SYNTAX_EXPECT_PDU,
      G_AT_SYNTAX_EXPECT_MULTILINE,
      G_AT_SYNTAX_EXPECT_PROMPT,
-    G_AT_SYNTAX_EXPECT_SHORT_PROMPT
+    G_AT_SYNTAX_EXPECT_SHORT_PROMPT,
+    G_AT_SYNTAX_EXPECT_GARBAGE,
  };

  typedef enum _GAtSyntaxExpectHint GAtSyntaxExpectHint;
@@ -42,6 +43,7 @@
      G_AT_SYNTAX_RESULT_MULTILINE,
      G_AT_SYNTAX_RESULT_PDU,
      G_AT_SYNTAX_RESULT_PROMPT,
+    G_AT_SYNTAX_RESULT_GARBAGE,
  };

  typedef enum _GAtSyntaxResult GAtSyntaxResult;


Our opinion is that the modem should only switch its
mode once it really received the NO CARRIER
signal (or something in this manner).

But it's up to you to find the best solution :)

>
> Regards,
> -Denis

Regards,
Marko

P.S. We would also like to post a patch regarding oFono.
How can we do this?

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono


--===============4437605044233084729==--

