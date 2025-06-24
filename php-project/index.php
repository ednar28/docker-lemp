<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nginx Status</title>
   <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>

<body class="min-h-screen bg-gradient-to-br from-green-50 to-blue-50 flex items-center justify-center p-4">
    <div class="max-w-2xl w-full space-y-6">
        <!-- Header -->
        <div class="text-center space-y-4">
            <div class="flex items-center justify-center gap-3">
                <svg class="w-12 h-12 text-green-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h14M5 12a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v4a2 2 0 01-2 2M5 12a2 2 0 00-2 2v4a2 2 0 002 2h14a2 2 0 002-2v-4a2 2 0 00-2-2m-2-4h.01M17 16h.01" />
                </svg>
                <h1 class="text-4xl font-bold text-gray-800">nginx</h1>
            </div>
            <div class="flex items-center justify-center gap-2">
                <svg class="w-6 h-6 text-green-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span class="px-3 py-1 rounded-full bg-green-100 text-green-700 text-sm font-medium">Status: Running</span>
            </div>
        </div>

        <!-- Main Content -->
        <div class="bg-white rounded-lg border border-green-200 shadow-lg overflow-hidden">
            <div class="bg-green-50 p-6 text-center">
                <div class="flex items-center justify-center gap-2 mb-4">
                    <svg class="w-8 h-8 text-green-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <h2 class="text-2xl font-bold text-green-800">Welcome to nginx!</h2>
                </div>

                <div class="space-y-4">
                    <p class="text-lg text-gray-700">Selamat! nginx web server Anda telah berhasil diinstall dan berjalan dengan baik.</p>
                    <p class="text-gray-600">Halaman ini menunjukkan bahwa nginx sudah aktif dan siap melayani konten web Anda.</p>
                </div>
            </div>

            <div class="p-6 space-y-6">
                <!-- Info Cards Grid -->
                <div class="grid md:grid-cols-2 gap-4">
                    <!-- Configuration Card -->
                    <div class="p-4 border border-blue-200 rounded-lg">
                        <div class="flex items-center gap-2 text-blue-700 mb-3">
                            <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                            </svg>
                            <h3 class="text-lg font-semibold">Konfigurasi</h3>
                        </div>
                        <div class="space-y-2 text-sm text-gray-600">
                            <p><strong>Config file:</strong> /etc/nginx/nginx.conf</p>
                            <p><strong>Document root:</strong> /var/www/html</p>
                            <p><strong>Error logs:</strong> /var/log/nginx/error.log</p>
                        </div>
                    </div>

                    <!-- Next Steps Card -->
                    <div class="p-4 border border-purple-200 rounded-lg">
                        <div class="flex items-center gap-2 text-purple-700 mb-3">
                            <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                            </svg>
                            <h3 class="text-lg font-semibold">Langkah Selanjutnya</h3>
                        </div>
                        <div class="space-y-2 text-sm text-gray-600">
                            <p>• Upload file website Anda</p>
                            <p>• Konfigurasi virtual hosts</p>
                            <p>• Setup SSL certificate</p>
                        </div>
                    </div>
                </div>

                <!-- Server Info -->
                <div class="bg-gray-50 rounded-lg p-4">
                    <h3 class="font-semibold text-gray-800 mb-3">Informasi Server</h3>
                    <div class="grid grid-cols-2 gap-4 text-sm">
                        <div>
                            <span class="text-gray-600">Server:</span>
                            <span class="ml-2 font-mono">nginx/1.24.0</span>
                        </div>
                        <div>
                            <span class="text-gray-600">Port:</span>
                            <span class="ml-2 font-mono">80, 443</span>
                        </div>
                        <div>
                            <span class="text-gray-600">Status:</span>
                            <span class="ml-2 text-green-600 font-semibold">Active</span>
                        </div>
                        <div>
                            <span class="text-gray-600">Uptime:</span>
                            <span class="ml-2 font-mono">Running</span>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <div class="text-center pt-4 border-t border-gray-200">
                    <p class="text-sm text-gray-500">
                        Untuk bantuan lebih lanjut, kunjungi
                        <a href="https://nginx.org/en/docs/" class="text-blue-600 hover:underline">dokumentasi nginx</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
