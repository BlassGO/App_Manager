.class public LMain;
.super Ljava/lang/Object;
.source "Main.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static DrawableAsPng(Landroid/graphics/drawable/Drawable;Ljava/lang/String;)V
    .registers 10
    .param p0, "drawable"  # Landroid/graphics/drawable/Drawable;
    .param p1, "path"  # Ljava/lang/String;

    .line 12
    if-nez p0, :cond_3

    return-void

    :cond_3
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v0

    .line 13
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v1

    .line 14
    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v2

    .line 15
    new-instance v3, Landroid/graphics/Canvas;

    invoke-direct {v3, v2}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 16
    const/4 v4, 0x0

    invoke-virtual {v2, v4}, Landroid/graphics/Bitmap;->eraseColor(I)V

    invoke-virtual {p0, v4, v4, v0, v1}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 17
    invoke-virtual {p0, v3}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    .line 19
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 21
    :try_start_25
    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 22
    new-instance v0, Ljava/io/BufferedOutputStream;

    const/16 v3, 0x2000

    invoke-direct {v0, v1, v3}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;I)V

    .line 23
    sget-object v3, Landroid/graphics/Bitmap$CompressFormat;->PNG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v5, 0x64

    invoke-virtual {v2, v3, v5, v0}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 24
    invoke-virtual {v0}, Ljava/io/BufferedOutputStream;->flush()V

    invoke-virtual {v0}, Ljava/io/BufferedOutputStream;->close()V

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V

    .line 25
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "icon:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_57
    .catch Ljava/io/IOException; {:try_start_25 .. :try_end_57} :catch_5d
    .catchall {:try_start_25 .. :try_end_57} :catchall_5b

    .line 26
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    goto :goto_70

    :catchall_5b
    move-exception v0

    goto :goto_71

    :catch_5d
    move-exception v0

    .line 27
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    sget-object v0, Ljava/lang/System;->err:Ljava/io/PrintStream;

    const-string v1, "Cant export as PNG."

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 28
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    :goto_6b
    return-void

    .line 29
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    goto :goto_6b

    .line 30
    :goto_70
    return-void

    .line 31
    :goto_71
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    throw v0
.end method

.method public static HasArg([Ljava/lang/String;Ljava/lang/String;)Z
    .registers 5
    .param p0, "args"  # [Ljava/lang/String;
    .param p1, "arg"  # Ljava/lang/String;

    .line 36
    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_2
    array-length v2, p0

    if-lt v1, v2, :cond_6

    .line 41
    return v0

    .line 37
    :cond_6
    aget-object v2, p0, v1

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_10

    .line 38
    const/4 v0, 0x1

    return v0

    .line 36
    :cond_10
    add-int/lit8 v1, v1, 0x1

    goto :goto_2
.end method

.method public static NextArg([Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 4
    .param p0, "args"  # [Ljava/lang/String;
    .param p1, "arg"  # Ljava/lang/String;

    .line 46
    const/4 v0, 0x0

    :goto_1
    array-length v1, p0

    if-lt v0, v1, :cond_6

    .line 54
    const/4 v0, 0x0

    return-object v0

    .line 47
    :cond_6
    aget-object v1, p0, v0

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_18

    array-length v1, p0

    add-int/lit8 v1, v1, -0x1

    if-ge v0, v1, :cond_18

    .line 49
    add-int/lit8 v0, v0, 0x1

    aget-object v0, p0, v0

    return-object v0

    .line 46
    :cond_18
    add-int/lit8 v0, v0, 0x1

    goto :goto_1
.end method

.method public static createZip(Ljava/lang/String;Ljava/lang/String;)V
    .registers 10

    .line 108
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 109
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 110
    new-instance v2, Ljava/util/zip/ZipOutputStream;

    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v2, v3}, Ljava/util/zip/ZipOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 111
    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    .line 112
    array-length v1, v0

    const/4 v3, 0x0

    :goto_1a
    if-ge v3, v1, :cond_52

    aget-object v4, v0, v3

    .line 113
    invoke-virtual {v4}, Ljava/io/File;->isFile()Z

    move-result v5

    if-eqz v5, :cond_4f

    .line 114
    new-instance v5, Ljava/util/zip/ZipEntry;

    invoke-virtual {v4}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/util/zip/ZipEntry;-><init>(Ljava/lang/String;)V

    .line 115
    invoke-virtual {v2, v5}, Ljava/util/zip/ZipOutputStream;->putNextEntry(Ljava/util/zip/ZipEntry;)V

    .line 116
    new-instance v5, Ljava/io/FileInputStream;

    invoke-direct {v5, v4}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 117
    const/16 v4, 0x400

    new-array v4, v4, [B

    .line 118
    :goto_39
    invoke-virtual {v5, v4}, Ljava/io/FileInputStream;->read([B)I

    move-result v6

    if-lez v6, :cond_44

    .line 119
    const/4 v7, 0x0

    invoke-virtual {v2, v4, v7, v6}, Ljava/util/zip/ZipOutputStream;->write([BII)V

    goto :goto_39

    .line 121
    :cond_44
    invoke-virtual {v5}, Ljava/io/FileInputStream;->close()V

    .line 122
    invoke-virtual {v2}, Ljava/util/zip/ZipOutputStream;->closeEntry()V

    .line 112
    add-int/lit8 v3, v3, 0x1

    goto :goto_1a

    .line 123
    move-exception v0

    goto :goto_5b

    .line 112
    :cond_4f
    invoke-static {v4}, LMain;->rm(Ljava/io/File;)V

    :cond_52
    invoke-virtual {v2}, Ljava/util/zip/ZipOutputStream;->close()V

    .line 126
    :goto_55
    goto :goto_73
    :try_end_56
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_56} :catch_56

    .line 124
    :catch_56
    move-exception v0

    .line 125
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_55

    .line 123
    :goto_5b
    :try_start_5b
    invoke-virtual {v2}, Ljava/util/zip/ZipOutputStream;->close()V
    :try_end_5e
    .catch Ljava/io/IOException; {:try_start_5b .. :try_end_5e} :catch_5e

    .line 126
    :catch_5e
    move-exception v1

    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_73

    .line 123
    :try_start_63
    invoke-virtual {v2}, Ljava/util/zip/ZipOutputStream;->close()V
    :try_end_66
    .catch Ljava/io/IOException; {:try_start_63 .. :try_end_66} :catch_66

    .line 126
    :catch_66
    move-exception v0

    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_73

    .line 123
    :try_start_6b
    invoke-virtual {v2}, Ljava/util/zip/ZipOutputStream;->close()V
    :try_end_6e
    .catch Ljava/io/IOException; {:try_start_6b .. :try_end_6e} :catch_6e

    .line 126
    :catch_6e
    move-exception v0

    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    nop

    .line 127
    :goto_73
    return-void
.end method

.method public static loadIcon(Ljava/lang/String;Landroid/content/Context;)Landroid/graphics/drawable/Drawable;
    .registers 10

    .line 34
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 35
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0xf

    if-lt v1, v2, :cond_3e

    .line 39
    const/4 v1, 0x0

    :try_start_b
    invoke-virtual {v0, p0, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v2

    .line 40
    const/4 v3, 0x2

    invoke-virtual {p1, p0, v3}, Landroid/content/Context;->createPackageContext(Ljava/lang/String;I)Landroid/content/Context;

    move-result-object p1

    .line 42
    const/4 v4, 0x3

    new-array v5, v4, [I

    const/16 v6, 0x140

    aput v6, v5, v1

    const/16 v6, 0xf0

    const/4 v7, 0x1

    aput v6, v5, v7

    const/16 v6, 0xd5

    aput v6, v5, v3

    .line 44
    nop

    :goto_25
    if-lt v1, v4, :cond_28

    .line 61
    goto :goto_3e

    .line 44
    :cond_28
    aget v3, v5, v1
    :try_end_2a
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_2a} :catch_3d

    .line 48
    :try_start_2a
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    iget-object v7, v2, Landroid/content/pm/PackageInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget v7, v7, Landroid/content/pm/ApplicationInfo;->icon:I

    invoke-virtual {v6, v7, v3}, Landroid/content/res/Resources;->getDrawableForDensity(II)Landroid/graphics/drawable/Drawable;

    move-result-object v3
    :try_end_36
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_2a .. :try_end_36} :catch_39
    .catch Ljava/lang/Exception; {:try_start_2a .. :try_end_36} :catch_3d

    .line 49
    if-eqz v3, :cond_3a

    .line 51
    return-object v3

    .line 54
    :catch_39
    move-exception v3

    .line 44
    :cond_3a
    add-int/lit8 v1, v1, 0x1

    goto :goto_25

    .line 62
    :catch_3d
    move-exception p1

    .line 68
    :cond_3e
    :goto_3e
    nop

    .line 71
    const/16 p1, 0x80

    :try_start_41
    invoke-virtual {v0, p0, p1}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object p0
    :try_end_45
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_41 .. :try_end_45} :catch_4b

    .line 72
    nop

    .line 78
    invoke-virtual {p0, v0}, Landroid/content/pm/ApplicationInfo;->loadIcon(Landroid/content/pm/PackageManager;)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    return-object p0

    .line 73
    :catch_4b
    move-exception p0

    .line 75
    const/4 p0, 0x0

    return-object p0
.end method

.method public static main([Ljava/lang/String;)V
    .registers 15
    .param p0, "args"  # [Ljava/lang/String;

    .line 132
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    move-object v4, v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move-object v5, v0

    const/4 v0, 0x0

    move-object v10, v0

    array-length v0, p0

    if-eqz v0, :cond_2a

    .line 133
    const-string v0, "-rm"

    invoke-static {p0, v0}, LMain;->HasArg([Ljava/lang/String;Ljava/lang/String;)Z

    move-result v7

    const-string v0, "-icon"

    invoke-static {p0, v0}, LMain;->NextArg([Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    if-eqz v10, :cond_2a

    .line 134
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v10}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    if-eqz v7, :cond_26

    invoke-static {v0}, LMain;->rm(Ljava/io/File;)V

    .line 135
    :cond_26
    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    goto :goto_46

    .line 137
    :cond_2a
    const/4 v10, 0x0

    const-string v0, "USER:"

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Landroid/app/ActivityManager;->getCurrentUser()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_3c

    move-exception v0

    const-string v0, "null"

    :goto_3c
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 140
    :goto_46
    invoke-static {}, Landroid/os/Looper;->prepareMainLooper()V

    .line 141
    invoke-static {}, Landroid/app/ActivityThread;->systemMain()Landroid/app/ActivityThread;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/ActivityThread;->getSystemContext()Landroid/app/ContextImpl;

    move-result-object v9

    .line 142
    invoke-virtual {v9}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 143
    const/16 v0, 0x2000

    invoke-virtual {v1, v0}, Landroid/content/pm/PackageManager;->getInstalledApplications(I)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_5f
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_115

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ApplicationInfo;

    move-object v3, v0

    .line 144
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move-object v5, v0

    if-nez v10, :cond_c9

    const/16 v0, 0x20

    iget-object v6, v3, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v1, v6, v0}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    goto :goto_80

    move-exception v0

    const-string v0, "UNINSTALLED"

    goto :goto_89

    :goto_80
    iget-boolean v0, v3, Landroid/content/pm/ApplicationInfo;->enabled:Z

    if-nez v0, :cond_87

    const-string v0, "DISABLED"

    goto :goto_89

    :cond_87
    const-string v0, "ENABLED"

    :goto_89
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ":"

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v6, 0x1

    iget v7, v3, Landroid/content/pm/ApplicationInfo;->flags:I

    and-int/2addr v7, v6

    if-eqz v7, :cond_9a

    const-string v6, "SYSTEM"

    goto :goto_9c

    :cond_9a
    const-string v6, "USER"

    :goto_9c
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v6, v3, Landroid/content/pm/ApplicationInfo;->uid:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v6, v3, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v6, v3, Landroid/content/pm/ApplicationInfo;->publicSourceDir:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v3}, Landroid/content/pm/PackageManager;->getApplicationLabel(Landroid/content/pm/ApplicationInfo;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_5f

    .line 147
    :cond_c9
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move-object v5, v0

    invoke-virtual {v5, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "/"

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, v3, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    move-object v6, v0

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ".png"

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_f3

    goto/16 :goto_5f

    :cond_f3
    invoke-static {v6, v9}, LMain;->loadIcon(Ljava/lang/String;Landroid/content/Context;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-static {v0, v5}, LMain;->DrawableAsPng(Landroid/graphics/drawable/Drawable;Ljava/lang/String;)V

    goto :goto_113

    move-exception v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move-object v5, v0

    const-string v0, "null:"

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, v3, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    :goto_113
    goto/16 :goto_5f

    .line 150
    :cond_115
    if-eqz v10, :cond_122

    const-string v0, "-zip"

    invoke-static {p0, v0}, LMain;->NextArg([Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_122

    invoke-static {v10, v0}, LMain;->createZip(Ljava/lang/String;Ljava/lang/String;)V

    .line 152
    :cond_122
    return-void
.end method

.method public static rm(Ljava/io/File;)V
    .registers 5
    .param p0, "file"  # Ljava/io/File;

    .line 157
    invoke-virtual {p0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_16

    .line 158
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_c
    if-ge v2, v1, :cond_16

    aget-object v3, v0, v2

    .line 159
    invoke-static {v3}, LMain;->rm(Ljava/io/File;)V

    .line 158
    add-int/lit8 v2, v2, 0x1

    goto :goto_c

    .line 162
    :cond_16
    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    return-void
.end method
